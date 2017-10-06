import ddf.minim.analysis.*;
import ddf.minim.*;
class MusicPlayer {

  Minim minim;
  AudioPlayer player = null;
  AudioInput playerInput =null;
  FFT fft;
  BeatDetect beat;
  boolean playing = false;
  boolean onInput = true;

  MusicPlayer (Minim minim, boolean onInput) {
    this.minim = minim;
    this.onInput = onInput;
    if (!onInput) {
      this.player = minim.loadFile(songFile, 1024);
      this.fft = new FFT( player.bufferSize(), player.sampleRate() );
    } else {
      this.playerInput = minim.getLineIn();
      this.fft = new FFT( playerInput.bufferSize(), playerInput.sampleRate() );
    }
    this.fft.logAverages( 22, 5 );
    this.beat = new BeatDetect();
  }

  void update() {
    
    if (!onInput) {
      //System.out.ln(player.position());
            //System.out.println(player.length());

      this.fft.forward( player.mix );
      beat.detect(player.mix);
      if ( player.position() == player.length() )
      {
        player.rewind();
      }
    } else {
        this.fft.forward( playerInput.mix );
        beat.detect(playerInput.mix);
    }
    if (playing)  calcBeat();
  }
  void play() {
    if (!onInput) {
       player.play(); 
       playing =true;
    }
  }
  
  void togglePlay() {
    if(!playing) {
      play();
    } else {
      pause();
    }
    
  }
  void skip(int amount) {
    if (!onInput) player.skip(amount);
  }
  void pause() {
    if (!onInput) {
      player.pause();
      playing = false;
    }
  }
  String getSong() {
    String rString = "";
    if (!onInput) {
      float amountDone = ((float)player.position() / player.length()) * 100 ;
      if(playing) {
        rString = String.format("Playing \"" + songFile + "\" " + "%.2f%%  Frames Per Beat: ", amountDone);
      } else {
        rString = String.format("Paused \"" + songFile + "\" " + "%.2f%%  Frames Per Beat: ", amountDone);
      }
      
    } else {
      rString = "On input";
    }
    return rString;
  }
  boolean playing() {
    return playing;
  }
  
  int bufferSize() {
    return player.bufferSize();
  }

  float[] getSpectrum() {

    float[] m = new float[fft.avgSize()];
    
    for (int i = 0; i < fft.avgSize(); i++)
    {
      m[i] =  fft.getAvg(i)*10;
    }
    return m;
  }
  
  AudioBuffer left() {
    return player.left;  
  }
  void rewind() {
    if (!onInput)  player.rewind();
    
  }
  
  int getSpecSize() {
    return fft.specSize();
  }
  void nextSong() {
    System.out.println("TODO: next song");  
  }
  
  boolean beatOnset () {
    return beat.isOnset();
  }
  float getFramesPerBeat() {
    return framesPerBeat;
  }
  
  float total = 0;
  float count = 0;
  float framesPerBeat = 20;
  int minCounter = 0;
  private void calcBeat() {
    count++;
    minCounter++;
    if (beatOnset() && minCounter >7) {
      framesPerBeat = (framesPerBeat * total + count) / (total + 1);
      count = 0;
      total++;
      minCounter= 0;
    }
    if(total > 100) {
      total =100;
    }
  }
  void resetBeat() {
    total = 0;
    framesPerBeat = 20;
    count = 0;
    minCounter = 0;



    }
}
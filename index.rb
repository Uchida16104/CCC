r=sample_names(sample_groups[7])[sample_names(sample_groups[1]).length-1]
s=sample_duration(r)
live_loop :ccc do
  with_fx :gverb,amp:1.5,room:10,damp:1,spread:1,dry:0.01,ref_level:1,tail_level:1 do
    with_fx :reverb,amp:1.5,room:1,damp:1 do
      with_fx :ring_mod,mix:rdist(-1).abs,freq: (scale :c,:major_pentatonic, num_octaves:2).tick,mix_slide:s*2,freq_slide:s*2 do |rm|
        with_fx [:bpf,:hpf,:lpf].choose,mix:rdist(1).abs,mix_slide:s*2 do |bhl| if one_in(2)
          with_fx :pitch_shift,mix:rdist(1).abs,pitch:rdist(1),mix_slide:s*2,pitch_slide:s*2 do |ps| if one_in(3)
            with_fx :vowel,mix:rdist(-1).abs,voice:[0,1,2,3,4].shuffle.tick,vowel_sound:[1,2,3,4,5].shuffle.tick,mix_slide:s*2,vowel_sound_slide:s*2,voice_slide:s*2 do |v| if one_in(4)
              for i in 0..sample_names(sample_groups[0]).length-1 do
                t=1
                u=sample r,start:t-1/4.to_f,finish:t,amp:Math::PI+rdist(1),amp_slide:t*2,pan:rdist(1),pan_slide:rdist(1).abs*2
                sleep s/16.to_f
                control u,amp:Math::PI+rdist(1),pan:rdist(-1)
                control rm,mix:rdist(1).abs,freq: (scale :c,:minor_pentatonic, num_octaves:2).tick
                control bhl,mix:rdist(-1).abs
                control ps,mix:rdist(-1).abs,pitch:rdist(-1)
                control v,mix:rdist(1).abs,voice:[0,1,2,3,4].shuffle.reverse.tick,vowel_sound:[1,2,3,4,5].shuffle.reverse.tick
              end
            end
          end
        end
        sleep 1/10.to_f
      end
      sleep 1/10.to_f
    end
    sleep 1/10.to_f
  end
end
end
end
end
header = nil
data = {}
File.read('chip1_vth-p_ari_2016.9.26.13.51.csv').each_line{|l|
  if header.nil?
    header = l.chop.split(',') 
  else
    vbs, vgs, vds, ids = l.chop.split(',').map{|a| a.to_f}
    data[vbs] ||= {}
    data[vbs][vgs] ||= {}
    data[vbs][vgs][vds] = ids
  end
}
puts data.keys.inspect
vds_array = data[0.0][0.0].keys.sort
#vgs_array = ['0', '0.1', '0.2']
vgs_array = data[0.0].keys.sort

@alta.meas_data.text<< "Vds, #{vgs_array.join(',')}"
vds_array.each{|vds|
  @alta.meas_data.text<< "#{vds}, #{vgs_array.map{|vgs| data[0.0][vgs][vds]}.join(',')}"
}

echo "Starting Stanford NER German"
# java -mx1000m -cp stanford-ner.jar edu.stanford.nlp.ie.NERServer -loadClassifier english.muc.7class.distsim.crf.ser.gz -port 8000 -outputFormat inlineXML &
#java -mx1000m -cp stanford-ner.jar edu.stanford.nlp.ie.NERServer -loadClassifier german.conll.germeval2014.hgc_175m_600.crf.ser.gz -port 8000 -outputFormat inlineXML &
java -mx1000m -cp stanford-ner.jar edu.stanford.nlp.ie.NERServer -loadClassifier german.distsim.crf.ser.gz -port 8000 -outputFormat inlineXML &

echo "Starting REST server"
forever index.js
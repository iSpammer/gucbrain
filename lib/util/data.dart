import 'dart:math';


Random random = Random();
List names = [
  "Ossama Akram",
  "Hussien El Feky",
  "Basant Anwar",
  "Mohamed Ahmed",
  "Eiad Essam",
  "Nada Hesham",
  "Slim Abdelnader",
  "Hassan Soubra",
  "Ahmed Abdelraouf",
];
List macs = [
  "11:22:33:44:55",
  "23:45:69:22:10",
  "57:39:20:35:11",
  "46:89:59:46:31",
  "89:46:37:22:84",
  "12:42:76:99:82",
  "36:77:24:99:81",
  "16:67:32:88:61",
  "32:68:46:31:33",
];

List types = ["recieved", "sent"];

List esps = [
  {
    "icon": "assets/esp.png",
    "name": "11:22:33:44:55",
    "alt": "ESP",
    "rate": r"20C ",
  },
  {
    "icon": "assets/esp.png",
    "name": "12:23:34:45:56",
    "alt": "ESP",
    "rate": r"22C	",
  },
  {
    "icon": "assets/esp.png",
    "name": "22:11:44:33:55",
    "alt": "ESP",
    "rate": r"22C	",
  },
  {
    "icon": "assets/esp.png",
    "name": "88:55:66:77:33",
    "alt": "ESP",
    "rate": r"22C	",
  },
  {
    "icon": "assets/esp.png",
    "name": "44:13:22:44:21",
    "alt": "ESP",
    "rate": r"22C	",
  },
];

List history = List.generate(9, (index)=>{
  "name": macs[random.nextInt(9)],
  "date": "${random.nextInt(31).toString().padLeft(2,"0")}"
      "/${random.nextInt(12).toString().padLeft(2,"0")}/2019",
  "amount": "${random.nextInt(30).toString()}C",
  "type": types[random.nextInt(2)],
  "dp": "assets/esp.png",
});


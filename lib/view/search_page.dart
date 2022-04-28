import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_client_vtc/drive/drive_bloc.dart';
import 'package:test_client_vtc/drive/drive_state.dart';
import 'package:test_client_vtc/search/search_bloc.dart';
import 'package:test_client_vtc/search/search_event.dart';
import 'package:test_client_vtc/search/search_state.dart';

import '../drive/drive_event.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => SearchBloc(SearchIntial())),
        BlocProvider(
            create: (BuildContext context) => DriveBloc(DriveInitial()))
      ],
      child: SearchView(),
    );
  }
}

enum DriveType { SOLO, MULTIPLE }

class SearchContent extends StatefulWidget {
  const SearchContent({Key? key}) : super(key: key);

  @override
  State<SearchContent> createState() => _SearchContent();
}

class _SearchContent extends State<SearchContent> {
  DriveType _value = DriveType.SOLO;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return BlocBuilder<DriveBloc, DriveState>(builder: (context, state) {
          return Column(
            children: [
              if (context.read<DriveBloc>().state is DriveInitial) ...[
                if (context.read<SearchBloc>().state is SearchIntial) ...[
                  ListTile(
                    title: const Text("Course avec d'autres clients"),
                    leading: Radio(
                      value: DriveType.MULTIPLE,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = DriveType.MULTIPLE;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Course classique'),
                    leading: Radio(
                      value: DriveType.SOLO,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = DriveType.SOLO;
                        });
                      },
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        context.read<SearchBloc>().add(SearchStarted());

                        await Future.delayed(const Duration(seconds: 3),
                            () async {
                          int nb = Random().nextInt(3);
                          switch (nb % 3) {
                            case 0:
                              context
                                  .read<SearchBloc>()
                                  .add(SearchAcceptedAsFirstClient());
                              await Future.delayed(const Duration(seconds: 3),
                                  () {
                                context.read<DriveBloc>().add(DriveStarted());
                              });

                              break;
                            case 1:
                              context.read<SearchBloc>().add(SearchTimedOut());

                              break;
                            case 2:
                              context
                                  .read<SearchBloc>()
                                  .add(SearchAcceptedAsNthClient(rank: 3));
                              await Future.delayed(const Duration(seconds: 3),
                                  () {
                                context.read<DriveBloc>().add(DriveStarted());
                              });
                              break;
                          }
                        });
                        // context.read<DriveBloc>().add(DriveStarted());
                      },
                      child: Text("Confirmer"))
                ],
                if (context.read<SearchBloc>().state is Pending) ...[
                  Center(child: Text("Recherche en cours ...")),
                  TextButton(
                      onPressed: () {
                        context.read<SearchBloc>().add(SearchCanceled());
                      },
                      child: Text("Annuler la course"))
                ],
                if (context.read<SearchBloc>().state is FirstClient) ...[
                  Center(
                      child: Text(
                    ''' Vous êtes le premier passager dans ce trajet , 
             veuillez patientez  a fin de trouver d'autres passagers qui partage la même destination ''',
                    textAlign: TextAlign.center,
                  )),
                ],
                if (context.read<SearchBloc>().state is NthClient) ...[
                  Center(
                      child: Text(
                    ''' Driver infos ''',
                    textAlign: TextAlign.center,
                  )),
                  Center(
                      child: Text(
                    ''' Le chauffeur arrivera dans quelques instants''',
                    textAlign: TextAlign.center,
                  )),
                ],
                if (context.read<SearchBloc>().state is DriverNotFound) ...[
                  Center(child: Text("Désolé aucun chaffeur n'a  été trouvé ")),
                  TextButton(
                      onPressed: () {
                        context.read<SearchBloc>().add(SearchCanceled());
                      },
                      child: Text("Réessayer"))
                ],
              ] else ...[
                if (context.read<DriveBloc>().state is onRoad) ...[
                  Center(
                      child: Text(
                          "Vous êtes en routes , vous arrivez dans quelques minutes à votre destination"))
                ],
                if (context.read<DriveBloc>().state is Arrived) ...[
                  Center(
                      child: Text(
                          "Vous êtes arrivé à votre destination , Notez votre expérience 1.. 5 !"))
                ]
              ]
            ],
          );
        });
      },
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Name')),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 300,
                child: Center(child: Text("MAP")),
              ),
              Container(
                child: Center(child: SearchContent()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

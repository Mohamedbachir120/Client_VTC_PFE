// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_client_vtc/drive/bloc/drive_bloc.dart';
import 'package:test_client_vtc/drive/bloc/drive_state.dart';
import 'package:test_client_vtc/drive/repository/drive_repo.dart';

import '../search/bloc/search_bloc.dart';
import '../search/bloc/search_event.dart';
import '../search/bloc/search_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DriveRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => SearchBloc(
                  searchState: SearchIntial(), 
                  driveRepository:RepositoryProvider.of<DriveRepository>(context) )),
          BlocProvider(
              create: (BuildContext context) => DriveBloc(
                    driveState: DriveInitial(),
                    driveRepository: RepositoryProvider.of<DriveRepository>(context)
,
                  ))
        ],
        child: SearchView(),
      ),
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
    return Column(
      children: [
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Column(children: [
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
                      },
                      child: Text("Confirmer"))
                ],
                if (state is Pending) ...[
                  Center(child: Text("Recherche en cours ...")),
                  TextButton(
                      onPressed: () {
                        context.read<SearchBloc>().add(SearchCanceled());
                      },
                      child: Text("Annuler la course"))
                ],
                if (state is DriverFounded) ...[
                  BlocBuilder<DriveBloc, DriveState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          if (state is OnRoad) ...[
                            Center(
                                child: Text(
                                    "Vous ??tes en routes , vous arrivez dans quelques minutes ?? votre destination")),
                          ],
                          if (state is Arrived) ...[
                            Center(
                                child: Text(
                                    "Vous ??tes arriv?? ?? votre destination , Notez votre exp??rience 1.. 5 !"))
                          ] else if(state is DriveInitial)...[
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
                            Center(
                              child: TextButton(
                                child: Text("Annuler"),
                                onPressed: () {
                                  context
                                      .read<SearchBloc>()
                                      .add(SearchCanceled());
                                },
                              ),
                            )
                          ]
                        ],
                      );
                    },
                  ),
                ],
                if (state is DriverNotFound) ...[
                  Center(child: Text("D??sol?? aucun chaffeur n'a  ??t?? trouv?? ")),
                  TextButton(
                      onPressed: () {
                        context.read<SearchBloc>().add(SearchCanceled());
                      },
                      child: Text("R??essayer"))
                ],
              
            ]);
          },
        ),
      ],
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

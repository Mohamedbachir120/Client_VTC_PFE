import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_client_vtc/search/search_bloc.dart';
import 'package:test_client_vtc/search/search_event.dart';
import 'package:test_client_vtc/search/search_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(SearchIntial()),
      child: const SearchView(),
    );
  }
}

enum DriveType { SOLO, MULTIPLE }

class DynamicContent extends StatefulWidget {
  const DynamicContent({Key? key}) : super(key: key);

  @override
  State<DynamicContent> createState() => _DynamicContent();
}

class _DynamicContent extends State<DynamicContent> {
  DriveType _value = DriveType.SOLO;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Column(
            children: [
              if (state is SearchIntial) ...[
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
                    onPressed: () {
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
              if (state is FirstClient) ...[
                Center(
                    child: Text(
                  ''' Vous êtes le premier passager dans ce trajet , 
             veuillez patientez  a fin de trouver d'autres passagers qui partage la même destination ''',
                  textAlign: TextAlign.center,
                )),
              ],
              if (state is NthClient) ...[

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
              if(state is DriverNotFound) ... [

                Center(child: Text("Désolé aucun chaffeur n'a  été trouvé ")),
                TextButton(onPressed: (){ 
                  
                  context.read<SearchBloc>().add(SearchCanceled());


                }, child: Text("Réessayer"))



              ]
            ],
          );
        });
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
                child: Center(child: DynamicContent()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

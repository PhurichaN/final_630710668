import 'package:final_630710668/page/vote_item.dart';
import 'package:final_630710668/services/api.dart';
import 'package:flutter/material.dart';

class Votepage extends StatefulWidget {
  const Votepage({Key? key}) : super(key: key);

  @override
  State<Votepage> createState() => _VotepageState();
}

class _VotepageState extends State<Votepage> {
  List<VoteItem>? _voteList;
  var _isLoading = false;
  String? _errMessage;

  @override
  void initState() {
    super.initState();
    _fetchVoteData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/logo.jpg',
              width: 500.0,

            ),
          ),
          Expanded(
              child: Stack(
                children: [
                  if (_voteList != null)
                    ListView.builder(
                      itemBuilder: _buildListItem,
                      itemCount: _voteList!.length,
                    ),
                  if (_isLoading) Center(child: CircularProgressIndicator()),
                  if (_errMessage != null && !_isLoading)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(_errMessage!),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _fetchVoteData();
                            },
                            child: const Text('RETRY'),
                          )
                        ],
                      ),
                    )
                ],
              ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                onPressed: _submitVotData,
                style: ElevatedButton.styleFrom(
                  //primary: Color(0xffb71c1c),
                  //maximumSize: Size(0,55),
                ),
                child: Text('VIEW RESULT'),
              ),),
            ],
          )

        ],
      ),

    );
  }

  void _fetchVoteData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var data = await Api().fetch('vote');
      setState(() {
        _voteList = data
            .map<VoteItem>((item) => VoteItem.fromJson(item))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    var voteItem = _voteList![index];

    return Card(
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Image.network(
              voteItem.image,
              width: 30.0,
              height: 50.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Column(
              children: [
                Text(voteItem.team),
                Text('group $voteItem.group'),
              ],
            ),
            //Expanded()
          ],

        ),
      ),
    );
  }
  void _submitVotData() {

  }

}

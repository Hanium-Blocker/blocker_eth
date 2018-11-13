pragma solidity ^0.4.2;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
        uint electionId;
    }

    //Model a Elections
    struct Elections{
        uint id;
        string name;
    }

    struct VoteRecord{
        uint election_id;
        bool isvoted;
    }

    //투표 기록 저장 매핑
    mapping(address => VoteRecord) public VoteRecords;

    // 투표 유무 저장
    mapping(address => bool) public voters;

    // 후보자 읽어오기
    mapping(uint => Candidate) public candidates;

    //선거 읽어오기
    mapping(uint => Elections) public elections;

    // 후보자 카운터
    uint public candidatesCount;
    
    //선거 카운터
    uint public electionCount;

    function Election () public {
        addElection("19대 대선");
        addCandidate("1.홍준표",1);
        addCandidate("2.문재인",1);
        addCandidate("3.안철수",1);
        addElection("20대 대선");
        addCandidate("1.홍길동",2);
        addCandidate("2.임꺽정",2);
        addCandidate("3.장길산",2);
    }

    function addCandidate (string _name,uint electionId) public {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0,electionId);
    }

    function addElection(string _name) public{
        electionCount ++;
        elections[electionCount]= Elections(electionCount,_name);
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before

        // require(!voters[msg.sender]);
        require(!VoteRecords[msg.sender].isvoted);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);


        VoteRecords[msg.sender].election_id= candidates[_candidateId].electionId;
        VoteRecords[msg.sender].isvoted = true;
        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

    }

    function getvoteCount(uint _candidateId) public view returns (uint) {
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        return candidates[_candidateId].voteCount;
    }

    function getelectionName(uint _electionId) public view returns(string){
        return elections[_electionId].name;
    }


}

pragma solidity ^0.4.2;

contract Election{
    //후보자 모델
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    //투표한 계정 저장
    mapping(address => bool) public voters;

    //후보자 저장


    //후보자 읽기
    mapping(uint=>Candidate) public candidates;

    //후보자 카운트
    uint public candidatesCount;

    //투표 이벤트
    event votedEvent(uint indexed_candidateId);

    //생성자
    function Election() public{
        addCandidate("candidate1");
        addCandidate("candidate2");
    }

    function addCandidate(string _name) private{
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount,_name,0);
    }

    function vote(uint _candidateId) public{
        //투표하지 않은 투표자에게 요청
        require(!voters[msg.sender]);

        //유효한 후보자 요청
        require(_candidateId > 0 && _candidateId <= candidatesCount); //require에 만족 하지 못하는 반환값이 온다면 이 함수는 예외를 던지고 멈춤.

        //투표한 유권자 기록하기
        voters[msg.sender] = true;

        //투표 카운트 갱신 코드
        candidates[_candidateId].voteCount ++;

        //투표 이벤트 트리거
        votedEvent(_candidateId);
    }
}
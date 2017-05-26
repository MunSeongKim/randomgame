class GameController < ApplicationController
  def index
    @title1 = Artii::Base.new(font: 'small').asciify('Wheel of Fortune!')
    #@title2 = Artii::Base.new(font: 'small').asciify('of')
    #@title3 = Artii::Base.new(font: 'small').asciify('Fortune!')
  end
  
  def game
    @title1 = Artii::Base.new(font: 'small').asciify('Wheel of Fortune!')
    #@title2 = Artii::Base.new(font: 'small').asciify('of')
    #@title3 = Artii::Base.new(font: 'small').asciify('Fortune!')
    
    if !params.equal?(nil)
      @hint = params[:hint]
      @word = params[:word]
      @count = params[:cnt].to_i + 1
      
      @wordLength = params[:word].equal?(nil) ? 0 : params[:word].length
      if !@word.equal?(nil) && @count == 0
        @blank = "_ " * @word.length
      else
        @blank = params[:blank]
      end
      
      
      answer = params[:answer]
      if answer != nil
        tmpBlank = @blank.split(" ")
        i = 0
        @word.each_char do |c|
          if answer == c
            tmpBlank[i] = c
          end
          i += 1
        end
        @blank = tmpBlank.join(" ")
      end
      
      tmp = @blank
      unless tmp.equal?(nil)
        @progress = ((tmp.scan(/[a-z]/).length.to_f / @word.length.to_f) * 100).to_i
      end
    end
  end
  
  def init
    wordList = {
      	abandon: '버리다|포기하다|폐기하다|유기하다|떠나다',
      	absolute: '절대적인|완전한|정말|가장 …한|확실한',
      	absolve: '용서하다|면제하다|사면하다',
      	abstain: '삼가다|절제하다|끊다',
      	accept: '받아들이다|수용하다|인정하다|입학시키다|응하다',
      	accessible: '접근할 수 있는|사용하기 쉬운|이용 가능한',
      	accommodate: '수용하다|맞추다|편의를 도모하다',
      	adapt: '…을 적응시키다|순응하다|개작하다',
      	adept: '숙련된|숙련자|숙달된',
      	adhere: '고수하다|들러붙다|달라붙다',
      	admittedly: '틀림없이|널리 인정되고 있는 것처럼|확실히',
      	adopt: '채택하다|입양하다|도입하다|취하다|적용하다',
      	advent: '출현|도래|그리스도의 강림',
      	adventitious: '우발적인|부정의|외래의',
      	adventurous: '모험을 좋아하는|대담한|위험이 많은',
      	adverse: '부정적인|반대의|불리한',
      	adversity: '역경|재난|불운',
      	affect: '영향을 주다|작용하다|감염시키다|…체하다',
      	affiliation: '관계|소속|협력|관련|제휴',
      	affirm: '확인하다|확언하다|긍정하다',
      	afford: '여유가 있다|할 수 있다',
      	agency: '기관|소속사|대행|에이전시|대리점',
      	agenda: '의제|과제|안건|아젠다|정책',
      	agile: '민첩한|명민한|기민한',
      	agitate: '선동하다|흥분시키다|휘젓다',
      	allege: '주장하다|진술하다|단언하다',
      	allocate: '할당하다|배분하다|책정하다',
      	allude: '암시하다|언급하다|넌지시 말하다',
      	amalgamate: '혼합시키다|합동하다|융합하다',
      	ambient: '포위한|주위의|온통 둘러싼',
      	amorphous: '무정형의|비결정질의|조직이 없는',
      	anecdote: '일화',
      	annex: '병합하다|부가물|합병하다',
      	antecedent: '선조|전례|선행하는',
      	anticipate: '기대하다|예상하다|예견하다',
      	antidote: '해독제|교정 수단|치료법',
      	antithesis: '대조',
      	apostate: '변절자|배교자|탈당자',
      	appeal: '호소|매력|항소|마음에 들다|상고',
      	apprehend: '…을 체포하다|이해하다|염려하다',
      	apprise: '통고하다|알리다|통지하다',
      	approve: '승인하다|허가하다|찬성하다|동의하다|인정하다',
      	approximate: '대강의|가까운|흉내내다',
      	arbitrary: '임의의|독단적인|제멋대로의',
      	arbitrator: 'arrest	체포하다|구속하다|검거하다|억류하다|저지하다',
      	articulate: '똑똑히 발음하다|체절 동물|음절로 나누다',
      	artifice: '책략|농간|기술',
      	artificial: '인공의|인위적인|인조의',
      	assert: '주장하다|단언하다|강력히 주장하다',
      	assess: '평가|결정|예측|검토|산정',
      	assiduous: '근면한|부지런한|끈기 있는',
      	assume: '가정하다|생각하다|추측하다|추정하다|맡다',
      	attest: '증명하다|…을 입증하다|증언하다',
      	attribute: '특성|원인으로 여기다|…로 여기다|…에 따른|때문이라고 생각한다',
      	avert: '피하다|회피하다|막다|방지|모면',
      	balk: '장애|방해하다|방해',
      	benefactor: '은인|후원자|은혜를 베푸는 사람',
      	beneficial: '이로운|유익한|도움이 되는',
      	beneficiary: '수혜자|수익자|수취인',
      	benefit: '이익|혜택|도움이 되다',
      	beset: '부진|시달리다|포위하다',
      	besiege: '포위하다|공격하다|쇄도하다',
      	bondage: '노예의 신분|속박|강제 노역',
      	border: '국경|경계|접해 있다|인접하다|가깝다',
      	capability: '능력|가능성|재능',
      	capacity: '능력|용량|가능성|기능|자격',
      	captious: '트집 잡는|책망하는|헐뜯는',
      	captivate: '…을 매혹하다|마음을 사로잡다|매혹시키다',
      	capture: '잡다|포착|체포|캡처|담다',
      	catchy: '재미있고 외기 쉬운|사람의 마음을 끄는|남을 걸려들게 하는',
      	celerity: '민첩함|민속|민첩',
      	change: '변화|바꾸다|변경|달라지다|전환하다',
      	circuitous: '에두르는|완곡한|에움길의',
      	circumference: '원주|주변|외주',
      	circumstance: '상황|환경|경우|사정|정황',
      	circumvent: '우회하다|…을 포위하다|일주하다',
      	clumsy: '서투른|눈치 없는|볼품없는',
      	coarse: '거친|상스러운',
      	cogency: '설득력|타당함|타당성',
      	coherent: '논리적인|일관성 있는|시종일관한',
      	collaborate: '협력하다|공동으로 하다|협동하다',
      	colleague: '동료',
      	collective: '집단적인|공동의|총괄적인|합쳐진',
      	collusion: '공모|결탁|음모',
      	commitment: '약속|헌신|공약|관련|의무',
      	commodity: '상품|원자재|생필품',
      	commotion: '동요|소란|격렬한 움직임',
      	commuter: '통근자|정기권 통근자|교외 통근자',
      	compensate: '보상하다|보완하다',
      	component: '성분|구성 요소|부품|컴포넌트 |부분',
      	comport: '행동하다|처신하다|어울리다',
      	compose: '구성하다|작곡하다|만들다|쓰다|조직하다',
      	compound: '화합물|복합의|합성물|혼합물|복잡하다',
      	comprehensive: '종합적인|포괄적인|광범위한',
      	compromise: '타협하다|절충하다|손상시키다|양보하다|노출시키다',
      	compulsory: '의무적인|강제적인|필수의',
      	concede: '인정하다|허용하다|굴복하다',
      	conceit: '자만|자부심',
      	conceive: '생각하다|임신하다|만들어지다|보다|구상',
      	concert: '콘서트|공연|음악회|연주회|협주곡',
      	concurrent: '동시 발생의|병발 사정|공동으로 작용하는',
      	condone: '용서하다|눈감아주다|죄를 관대히 봐주다',
      	confer: '수여하다|협의하다|상담하다',
      	confirm: '확인하다|확정하다|확신하다|확실히 하다',
      	conform: '일치하다|따르다',
      	congest: '혼잡하게 하다|가득차다|꽉 채우다',
      	conjunction: '접속사|연대|관련|공동|동시 발생',
      	conservative: '보수적인|보수주의자|수수한',
      	conserve: '…을 보존하다|보호하다|절약하다',
      	consistent: '일관된|지속적인|일치하는|일리가 있는',
      	consolidate: '통합하다|강화하다|공고해지다|튼튼해지다|굳히다',
      	constant: '일정한|지속적인|끊임없는|계속되는|부단한',
      	constitute: '구성하다|간주하다|…에 해당하다|제정하다|나타내다',
      	constrict: '…을 압축하다|수축하다|…을 단단히 죄다',
      	consume: '소비하다|먹어치우다|시간이 걸리다|…을 낭비하다|사로잡히다',
      	contagious: '전염성의|접촉 전염성의|전염성 있는',
      	contaminate: '…을 오염시키다|더럽히다|악에 물들게 하다',
      	contempt: '경멸|모욕|무시',
      	contest: '대회|콘테스트|경쟁하다|선거',
      	contiguous: '인접하는|인접하고 있는|접근하는',
      	contingent: '조건으로 하는|파견단|분담액',
      	continually: '계속해서|지속적으로|끊임없이|자꾸',
      	contour: '윤곽|외형',
      	contrary: '반대의|정반대의|반하여|상반되는|모순된',
      	contravene: '위반하다|반대하다|위반 행위를 하다',
      	contribute: '기여하다|공헌하다|도움이 되다|원인|제공하다',
      	controversial: '논란의|문제의|논쟁의|갈등을 빚고 있는',
      	convene: '소집하다|…을 소환하다|회합하다',
      	convenience: '편의|편리|편한|편익|용이함',
      	conventional: '전통적인|틀에 박힌|관습의',
      	converge: '집중하다|…을 한 점에 모으다|모이다',
      	converse: '대화하다|이야기하다|반대',
      	convert: '전환하다|바꾸다|개조하다|개종하다|득점하다',
      	cooperate: '협력하다|협조하다|협동하다',
      	counteract: '…에 반대로 작용하다|…을 방해하다|좌절시키다',
      	counterfeit: '…을 위조하다|위조의|가짜의',
      	courier: '택배업자|배달원|전하는|운반인|심부름',
      	craft: '공예|만들다|비행기|선박|솜씨',
      	cramped: '경련을 일으킨|비좁고 갑갑한|쥐가 난',
      	curb: '억제하다|막다|감소|제한하다|제어',
      	current: '현재의|전류|현행의|지금의|해류',
      	curse: '저주|욕설|재앙|비난|걱정',
      	cursory: '피상적인|겉핥기의|겉핥기식의',
      	debris: '잔해|파편|쓰레기|폐기물|조각',
      	decelerate: '감속하다|속도를 줄이다|속력을 늦추다',
      	deceptive: '속이는|현혹시키는|남을 속이는',
      	defeat: '패배시키다|이기다|물리치다|무찌르다',
      	defect: '결함|장애|탈주|이탈',
      	defer: '연기하다|결정을 맡기다|경의를 표하다',
      	deficiency: '부족|결함',
      	deft: '솜씨 좋은|능숙한|날랜',
      	defunct: '죽은|현존하지 않는|멸종한',
      	degrade: '떨어뜨리다|비하|훼손|퇴화|악화',
      	delegate: '대표|대의원|위임하다|사절',
      	delinquent: '비행의|의무 불이행의|비행 소년',
      	deliver: '전달하다|배달하다|전하다|구해내다|분만하다',
      	delusive: '기만적인|망상적인|믿을 수 없는',
      	demise: '서거|사망|…을 양도하다',
      	depend: '따라|의존하다|달리다|의지하다|좌우되다',
      	deport: '추방하다|강제 이송하다|행동하다',
      	depose: '폐|물러나다|퇴위시키다|면직하다|타도',
      	derelict: '유기된|버려진|직무 태만자',
      	deride: '조소하다|…을 비웃다',
      	desert: '사막|버리다|비우다|탈영하다|황무지',
      	deserve: '자격|만하다|마땅히|가치|싸다',
      	destitute: '빈곤한|가난한|결핍한',
      	desultory: '일관성 없는|산만한|종잡을 수 없는',
      	detach: '단독의|분리하다|떼다|동떨어진|초연한',
      	detain: '지체하게 하다|구류하다|붙들다',
      	detest: '혐오하다|매우 싫어하다|몹시 싫어하다',
      	dexterity: '손재주 있음|민첩함|능숙함',
      	dialect: '방언|지방 사투리|지방어',
      	differentiate: '…을 구별하다|차별하다|차이가 생겨나다',
      	digressive: '지엽적인|주제를 벗어나기 쉬운|본론을 떠난',
      	dilatory: '꾸물거리는|지체하는|더딘',
      	disband: '해산하다|제대시키다|해체하다',
      	discharge: '방출하다|퇴원하다|제대하다|해고하다|이행하다',
      	discipline: '규율|훈련|훈육|학문|기강',
      	discomfit: '…을 당황하게 하다|좌절시키다|패배',
      	disentangle: '풀리다|…의 얽힘을 풀다|…을 해방하다',
      	disintegration: '붕괴|분해|분열',
      	dismiss: '일축하다|무시하다|해고하다|기각하다|각하하다',
      	dispel: '…을 쫓아버리다|없애다|떨쳐버리다',
      	dispense: '나눠주다|조제하다|분배해주다|제공|나오다',
      	disposal: '처리|처분|폐기',
      	dispose: '폐기하다|처리하다|처분하다|없애다',
      	disposition: '성향|처분|기질|생각',
      	dissolve: '녹이다|없애다|해산하다|해소하다',
      	distribute: '나눠주다|배포하다|분배하다|공급하다|기부하다',
      	disturb: '방해하다|혼란시키다|교란하다|어지럽히다|불안하게 하다',
      	divergent: '분기하는|벗어난|갈라지는',
      	diversion: '전환|유용|딴 데로 돌림',
      	diversity: '다양성|상이|변화',
      	donate: '기부하다|기증하다',
      	dose: '복용|1회분|약간의',
      	dote: '노망하다|망령들다|맹목적으로 사랑하다',
      	drag: '끌어내다|장애물|떨어뜨리다|계속되다|늑장부리다',
      	drastic: '철저한|맹렬한|격렬한',
      	drive: '운전하다|구동하다|차로|드라이브|가다',
      	durable: '내구력이 있는|튼튼한|오래 견디는',
      	eclipse: '식|가리다|이클립스|에클리제|상쇄',
      	effect: '영향|효과|발효|결과|현상',
      	efficient: '효율적인|효과적|능률적인|유능한',
      	elaborate: '상세히 말하다|정교한|설명하다|정성들인',
      	elastic: '탄력 있는|신축성이 있는|고무줄|융통성이 있는',
      	elated: '의기양양한|우쭐한|우쭐대는',
      	elective: '선거의|선택 과목|선거로 임용되는',
      	eligible: '자격이 있는|권한이 있는|가능한',
      	elude: '이해되지 않다|피하다|잘 피하다',
      	emanate: '발산하다|나오다|퍼지다',
      	eminent: '저명한|탁월한',
      	emit: '방출하다|내뿜다|발산하다',
      	empirical: '경험적인|경험의|실증적인',
      	enact: '제정하다|규정하다|상연하다',
      	encompass: '…을 둘러싸다|…을 포함하다|포위하다',
      	endow: '기부하다|…에게 부여하다|재산을 증여하다',
      	endure: '견디다|지속하다|겪다|이기다|허락하다',
      	enigma: '수수께끼|불가해한 사물|수수께끼 그림',
      	enterprising: '진취적인|적극적인',
      	evade: '회피하다|피하다|면하다',
      	eventually: '결국|마침내|최종적으로|언젠가는',
      	exaggerate: '과장하다|지나친',
      	exceed: '넘어서다|초과하다|능가하다',
      	exemplary: '전형적인|모범적인|본보기의',
      	exempt: '면제하다|면제된|면해주다',
      	exert: '영향을 미치다|행사하다|압력을 가하다|노력하다',
      	exile: '망명|추방|도피',
      	exorbitant: '터무니없는|과도한|엄청난',
      	expensive: '비싼|돈이 많이 드는|고가의|많은 비용|사치스러운',
      	exponent: '대표자|옹호자',
      	expose: '노출하다|보이다|폭로하다|드러내다|경험하다',
      	expostulation: '훈계|간언|충고',
      	extrovert: '외향성인 사람|외향형|외향성의',
      	facilitate: '위하다|촉진하다|활성화|용이|가능하게',
      	facility: '시설|설비|재능',
      	factor: '요인|원인|요소|유전자|인수',
      	faculty: '교수진|교직원|능력|학부',
      	fascinate: '매료시키다|사로잡다|관심을 보이다|매혹시키다',
      	fast: '빨리|빠른|단식하다|단식일|깊게',
      	fastidious: '까다로운|성미가 까다로운|세심한 주의가 필요한',
      	feasible: '실행할 수 있는|실현 가능한|적당한',
      	feat: '위업|공적|묘기',
      	feature: '특징|출연하다|기능|특집|얼굴',
      	fertile: '비옥한|가임의|다산의',
      	fictitious: '허구의|거짓의|가공의',
      	fit: '꼭 맞는|부합|어울리는|건강한|착용',
      	fleeting: '덧없는|어느덧 지나가는|무상한',
      	forerunner: '선인|선조|선구자',
      	forfeit: '몰수|벌금|상실하다',
      	formal: '공식적인|정식의|형식적인|정규의|정장',
      	frenzied: '광적인|열광한|열광적인',
      	fugacious: '쉽게 지는|덧없는|휘발성의',
      	fugitive: '도망자|도피자|탈주자|도주한',
      	gestation: '임신|잉태 기간|잠복기',
      	gradual: '점진적인|조금씩',
      	halt: '중단|멈추다|막다|중지하다|마비',
      	hamper: '방해하다|방해물|큰 바구니',
      	hard: '열심히|어려운|힘든|강경한|고생',
      	harsh: '가혹한|거친|강경한|냉엄한|거슬리는',
      	hoarse: '쉰 목소리의|쉰|목이 쉰',
      	horizontal: '수평의|가로의|바로 누운',
      	hypothesis: '가설|가정|추측',
      	illusion: '착각|환상|일루전|가상|망상',
      	imminent: '절박한|임박한|일촉즉발의',
      	immune: '면역의|면제된|면역이 된',
      	impasse: '교착|난국|답보|대립|파행',
      	impel: '재촉하다|억지로 …시키다|추진시키다',
      	impending: '절박한|임박한|곧 일어날 듯한',
      	imperceptible: '미세한|근소한|감지될 수 없는',
      	imperturbable: '냉정한|침착한|쉽사리 동요하지 않는',
      	impetuous: '충동적인|성급한|맹렬한',
      	impetus: '자극|기동력|힘',
      	impose: '부과하다|제한하다|적용하다|강요하다|시행하다',
      	impractical: '비현실적인|비실용적인',
      	impregnable: '난공불락의|확고한|수정 가능한',
      	improbable: '일어날 성싶지 않은|정말 같지 않은|불가능한',
      	impromptu: '즉석에서|즉흥적으로|즉석의',
      	impulse: '충동|자극|원동력|욕망',
      	inactive: '활발하지 않은|활동하지 않는|소극적인',
      	inadvertently: 'without knowledge or intention',
      	incapacitate: '…을 무능하게 하다|…을 실격시키다|능력을 빼앗다',
      	incessant: 'uninterrupted in time and indefinitely long continuing',
      	incontrovertible: '명백한|논쟁의 여지가 없는|논의할 여지없는',
      	indifferent: '무관심한|무심한|냉담한|무관한|모르는 척',
      	indispensable: '필수적인|불가결한|꼭 필요한',
      	inefficacious: '바람직한 효과가 없는|효력 없는|효험 없는',
      	inept: '서투른|부적당한|부적절한',
      	inertia: '관성|타성|불활발',
      	infectious: '전염성의|감염성|병적인|중독성 강한',
      	infer: '추론하다|추측하다|언급하다',
      	infertile: '메마른|불모의|생식력이 없는',
      	infirm: '약한|허약한|약해진',
      	ingest: '섭취하다|수집하다|받아들이다',
      	ingredient: '재료|성분',
      	initial: '초기의|원래의|1차|첫 글자|선도하는',
      	initiative: '새로운 계획|주도권|조치|이니셔티브|선제의',
      	insidious: '교활한|음흉한|방심할 수 없는',
      	insist: '주장하다|고집하다|요구하다|강요하다',
      	insoluble: '해결할 수 없는|용해되지 않는|녹지 않는',
      	insolvent: '파산한|지급 불능의|파산의',
      	instantaneous: '순간적인|즉시적인|즉각적인',
      	institute: '연구소|전문교육기관|대학교|협회|시행하다',
      	intact: '손상되지 않은|온전한|원래대로의',
      	integral: '완전한|필수의|전체',
      	intellectual: '지적인|지식인|지성인|인텔리',
      	intercede: '중재하다|탄원하다|조정하다',
      	interfere: '간섭하다|방해하다|지장을 주다|침해하다|충돌하다',
      	interlude: '막간|사이에 생긴 일|막간 촌극',
      	intermittent: '간헐적인|단속적인|일시적으로 멈추는',
      	intervene: '개입하다|끼어들다|사이에 있다',
      	invade: '침략하다|침공|침입하다|침범|공격',
      	invariant: '불변의|불변식|변함없는',
      	invent: '발명하다|개발하다|고안하다|창조하다',
      	itinerant: '순회하는|순회자|편력자',
      	itinerary: '일정|기행|여행|여정',
      	labor: '노동|근로|노력|진통|출산',
      	laborious: '근면한|힘드는|어려운',
      	lag: '지연|지체|…을 투옥하다',
      	lax: '느슨한|로스엔젤레스 공항|태만한',
      	leap: '도약하다|건너 뛰다|상승하다|발전하다|자살하다',
      	lease: '임대하다|리스|임대 계약서|대여하다|민간자본유치사업',
      	leftover: '나머지|나머지의|찌꺼기',
      	legacy: '유산|업적|결과|여파|유물',
      	liability: '의무|책임|부채',
      	liberate: '해방하다|자유롭게 하다|벗어나다',
      	linger: '지속되다|남아 있다|서성대다|그림자를 드리우다',
      	liquidate: '청산하다|정리하다|폐지하다',
      	locate: '위치하다|찾아내다|자리잡고 있다|발견하다|위치를 찾다',
      	locomotion: '이동|운동|이동력',
      	ludicrous: '익살맞은|바보 같은|웃음을 자아내게 하는',
      	magnificence: '장엄|웅장|웅대',
      	maintain: '유지하다|계속하다|주장하다|관리하다|지속하다',
      	makeshift: '임시변통의|임시변통의 물건|임시의',
      	match: '경기|어울리다|성냥|짝|조화되다',
      	menace: '위협하다|위험|협박하다',
      	metamorphosis: '변형|변태|변성',
      	mob: '폭도|집단|군중',
      	mobile: '휴대전화|모바일|무선|활동적인|모빌',
      	moderate: '사회를 보다|온건한|적당한|중도의|완화하다',
      	modify: '변경하다|변형하다|조절하다',
      	moment: '순간|지금|때|잠깐|기회',
      	momentarily: '일시적으로|곧|한때|잠정적으로',
      	momentous: '중요한|중대한|비상한',
      	motivate: '…에게 동기를 주다|자극하다',
      	moving: '움직이는|감동시키는|감동적인',
      	mutable: '변덕스러운|변하기 쉬운|가변성의',
      	mutual: '상호적인|서로의|공동의',
      	navigate: '길을 찾다|항해하다|돌아다니다|안내하다|잘 다루다',
      	obdurate: '완고한|고집 센|고집이 센',
      	obituary: '사망의|사망 기사|부고',
      	obligatory: '의무적인|필수의|강제적인',
      	observe: '관찰하다|보다|지키다|준수하다|목격하다',
      	obstinate: '완고한|고집센|고치기 힘든',
      	occupation: '직업|점령|일제 식민통치',
      	occur: '발생하다|일어나다|생기다|나타나다|발견되다',
      	officious: '비공식의|참견하기 좋아하는|주제넘게 나서는',
      	offset: '…을 상쇄하다|벌충하다|상쇄하는 것',
      	omit: '누락하다|제외하다|생략하다|…이 없는|빠지다',
      	onset: '개시|시작|착수',
      	opponent: '반대의|상대|적|경쟁자',
      	opportune: '적절한|시의에 맞는|시기가 좋은',
      	opposite: '정반대의|상대|상반되는|맞은편의|서로 마주하는',
      	opt: '선택하다|고르다|채택하다',
      	orbit: '궤도|돌다|안구',
      	outmoded: '시대에 뒤진|지금은 쓸모없는|유행에 뒤진',
      	outstanding: '현저한|뛰어난|눈에 띄는',
      	palpable: '명백한|만질 수 있는|촉진할 수 있는',
      	penchant: '경향|강한 기호|취미',
      	pension: '연금|연기금|퇴직금|자산|펜션',
      	perceive: '인지하다|인식하다|…로 생각하다|인상을 주다',
      	performance: '성능|성과|공연|수행|경기',
      	perfunctory: '형식적인|피상적인|겉치레의',
      	perilous: '위험한',
      	perishable: '썩기 쉬운|소멸하기 쉬운|영속하지 않는',
      	permanent: '영구적인|상설의|정규직의|영원한|파마',
      	permit: '허가하다|허용하다|허락하다|용납하다',
      	perpendicular: '수직의|수직선|직립한',
      	persistent: '지속하는|끈기 있는|끊임없는',
      	pertinent: '적절한|관계가 있는|부속물',
      	perturb: '혼란시키다|…을 당황하게 하다|교란하다',
      	pervasive: '퍼지는|스며드는|골고루 미치는',
      	perverse: '심술궂은|사악한|기대에 어긋나는',
      	portable: '휴대용의|이동식|포터블',
      	postpone: '연기하다|미루다|지연시키다|연장하다|늦추다',
      	postulate: '가정|…을 요구하다|…을 가정하다',
      	posture: '자세|태세|배치하다|태도',
      	pragmatic: '실용적인|실용주의의|분주한',
      	precedent: '선례|앞서는|전례',
      	precept: '교훈|격언|가르침',
      	predilection: '편애|좋아함|두둔',
      	preemptive: 'designed or having the power to deter or prevent an anticipated situation or occurrence',
      	prefer: '선호하다|좋아하다',
      	premise: '전제|건물|토지|기본|선행조건',
      	preserve: '보존하다|보호하다|유지하다|지키다|보전하다',
      	presume: '추정하다|가정하다|추측하다',
      	presumptuous: '주제넘은|뻔뻔스러운|건방진',
      	prevent: '막다|방지하다|예방하다|못하게 하다|금지하다',
      	probation: '보호 관찰|집행 유예|시험',
      	probe: '조사하다|수사하다|탐사하다|규명하다',
      	probity: '성실|고결|청렴결백',
      	proceed: '진행하다|수익|계속하다|추진하다|나아가다',
      	procrastinate: '미루다| 끌다|연기하다',
      	prodigal: '낭비하는|방탕한|풍부한',
      	proficient: '능숙한|숙달한|익숙한',
      	profitable: '수익성이 좋은|이익이 되는|이윤을 내는|돈벌이가 되는|도움이 되는',
      	progressive: '진보적인|진행하는|점진적인|진보주의의',
      	proliferate: '증식하다|번식하다|급증하다',
      	prominent: '유명한|두드러진|뛰어난|탁월한|실력 있는',
      	promote: '홍보하다|증진하다|촉진하다|활성화시키다|장려하다',
      	prompt: '촉발하다|신속한|촉구하다',
      	propensity: '경향|성향|기호',
      	propinquity: '근접|근친|가까움',
      	proponent: '제안자|지지자|발의자',
      	proposition: '제안|명제|프로포지션|주장',
      	propriety: '예의 바름|적당|타당',
      	protest: '시위|항의|반대하다|저항|데모',
      	prototype: '원형|시제품|모델|견본|기본형',
      	provenance: '기원|출처|유래',
      	proximity: '근접|가까움|접근',
      	purport: '취지|의도|칭하다',
      	purpose: '목적|목표|용도|의도|명분',
      	range: '범위|이르다|영역|사거리|산맥',
      	ravage: '황폐|파괴|…을 약탈하다',
      	recede: '멀어지다|감소하다',
      	receptive: '감수성이 풍부한|잘 받아들이는|수용하는',
      	recess: '휴회|휴식|쉬다|휴정|휴가',
      	recipient: '이식자|받는|수금자|수상자|수혜자',
      	recollection: '기억|회상',
      	recourse: '의지|맡기다|소송|청구|수단',
      	recuperate: '회복하다|되찾다|건강을 되찾게 하다',
      	recurring: '순환하는|거듭 발생하는|되풀이되는',
      	redeem: '만회하다|교환|구하다|보상|상환하다',
      	refer: '말하다|언급하다|부르다|뜻하다|가리키다',
      	referendum: '국민 투표|훈령 요청서|레퍼렌덤',
      	regression: '퇴화|복귀|회귀',
      	reimburse: '상환하다|배상하다|변상하다',
      	reiterate: '되풀이하다|다시 행하다|장황하고 지루하게 반복하다',
      	relate: '관련시키다|관계시키다|연관되다|연결되다',
      	release: '발표하다|개봉하다|공개하다|발매하다|출시하다',
      	relegate: '좌천시키다|…을 내려앉히다|이관하다',
      	reliable: '신뢰할 만한|믿을 만한|신빙성 있는|믿음직한',
      	relinquish: '포기하다|양도하다|그만두다',
      	remiss: '태만한|부주의한|무기력한',
      	remit: '송금하다|면제하다|보내다',
      	remnant: '나머지|자투리|유물',
      	remote: '원격의|외딴|먼|리모컨|희박한',
      	remuneration: '보상|보수|급료',
      	render: '되게 하다|표현하다|제공하다',
      	repeal: '폐지|폐지하다|무효로 하다',
      	repel: '쫓아버리다|격퇴하다|물리치다',
      	replace: '대체하다|교체하다|대신하다|바꾸다|후임으로 임명되다',
      	reprehensible: '괘씸한|비난받을 만한|비난받아야 할',
      	reprove: '꾸짖다|비난하다|책망하다',
      	reserve: '보유하다|보호지역|준비의|예비|확보해두다',
      	residue: '나머지|잔여|잔류물',
      	resilient: '회복력|탄성|끈질긴|튼튼한|강력한',
      	resistant: '내성|저항|강한|견디는|방지',
      	resolution: '해상도|결의|해결|결심|결정',
      	resolve: '해결하다|결의하다|대책을 마련하다|해법',
      	resort: '리조트|의존하다|휴양지|수단',
      	restive: '반항적인|차분하지 못한|침애하지 못한',
      	restrain: '제한하다|자제하다|검거하다|금지하다|압박하다',
      	restrict: '제한하다|규제|금지하다|제약|통제',
      	resume: '재개하다|이력서|다시 시작하다|되찾다',
      	retain: '유지하다|보유하다|가지다|계속하다|남겨두다',
      	retard: '…을 늦추다|방해하다|지연',
      	retribution: '응보|보복|징벌',
      	revenue: '매출|수입|수익|세입|순이익',
      	reverse: '반대의|뒤집다|바꾸다|되돌리다|파기하다',
      	revert: '되돌아가다|복귀하다|회고하다',
      	revulsion: '격변|혐오|반감',
      	ridiculous: '말도 안 되는|터무니없는|우스꽝스러운|우스운|어리석은',
      	rigorous: '엄격한|혹독한|정밀한',
      	salient: '현저한|두드러진|돌출부',
      	scourge: '재앙|사회악|끔찍한 |해악|채찍질하다',
      	secede: '탈퇴하다|탈당하다',
      	sedative: '진정제|진정시키는',
      	sedentary: '앉아서 하는|앉아 있는|앉은 자세의',
      	sediment: '침전물|앙금|퇴적물',
      	serve: '제공하다|복무하다|봉사하다|근무하다|대접하다',
      	servitude: '예속|노예 상태|징역',
      	setback: '좌절|실패|역행',
      	settle: '해결하다|정착하다|타협을 보다|진정시키다|결정하다',
      	shackle: '족쇄|쇠고랑|갇히다|사슬|잡다',
      	shift: '변화|전환|이동하다|바뀌다|옮기다',
      	slack: '게으름|여유|바지|해이해져|되는대로의',
      	sloth: '나무늘보|나태|게으름',
      	slovenly: '단정치 못한|되는대로|되는대로의',
      	sluggish: '느린|부진한|게으른',
      	solidify: '응고하다|굳어지다|응고시키다',
      	speeding: '속도위반|과속|고속 진행',
      	splice: '…을 결혼시키다|꼬아 잇다|꼬아 잇기',
      	stable: '안정적인|마구간|외양간|견실한',
      	stake: '지분|걸다|말뚝|제공하다',
      	stale: '딱딱해진|상한|진부한|김빠진',
      	stalemate: '…을 수가 막히게 하다|스테일메이트|막다른 궁지',
      	staple: '주요한|주요 산물|기본 식품',
      	stasis: '균형 상태|「정지」 「안정 상태」의 뜻|울혈',
      	state: '국가|상태|주|정부|…을 분명히 말하다',
      	station: '정거장|역|방송국|기지|주둔하다',
      	stature: '신장|키|성장|위업',
      	status: '상태|지위|신분|현상|사정',
      	statute: '법령|법규|성문법',
      	steadfast: '확고한|고수하다|확고부동한|불변의',
      	stem: '줄기|생기다|막다|뿌리|다리',
      	stereotyped: '진부한|판에 박은|틀에 박힌',
      	stick: '막대기|붙다|고수하다|갇히다|찌르다',
      	strain: '변형|종류|긴장|균주|피로',
      	stratagem: '전략|계략|책략',
      	strenuous: '격렬한|분투적인|활기찬',
      	strict: '엄격한|강력한|철저한|엄중한|지나친',
      	string: '줄|현악|일련|조건|묶다',
      	stringent: '엄격한|강화|엄중한|까다로운|엄한',
      	submit: '제출하다|제시하다|복종하다|굴복하다',
      	subside: '가라앉다|침묵하다|진정되다',
      	subsidize: '원조하다|후원하다|보조해주다',
      	subsist: '존재하다|살아가다|존속하다',
      	substantial: '상당한|실질적인|중대한|현저한|튼튼한',
      	substantiate: '…을 구체화하다|…을 확증하다|입증하다',
      	substitute: '대체하다|대신|대용하다|대리|대안',
      	subterfuge: '핑계|구실|기피',
      	subversive: '전복시키는|파괴하는|파괴적인',
      	succeed: '성공하다|뒤를 잇다|후임이 되다|계속되다|대신하다',
      	succinct: '간결한|간명한|말의 간결성이 특징인',
      	suffer: '겪다|고통을 받다|앓다|입다|고생하다',
      	sufficient: '충분한|만족스러운',
      	sumptuous: '사치스러운|값비싼|호화로운',
      	superficial: '피상적인|겉으로 드러나는|외부의|천박한',
      	supersede: '대체하다|대신하다|교체하다|자리를 바꾸다',
      	superstition: '미신',
      	supplant: '대체하다|대신하다|대신 들어앉다',
      	support: '지원하다|지지하다|뒷받침하다|돕다|유지하다',
      	supposition: '가정|상상|추정',
      	surfeit: '과도|과식|폭식',
      	surmise: '추측하다|추측|짐작',
      	surpass: '넘어서다|앞서다|돌파하다|초과하다|극복하다',
      	surrender: '항복하다|포기하다|인도하다|자수하다|몸을 맡기다',
      	surreptitious: '비밀의|뒤가 구린|몰래 하는',
      	susceptible: '영향을 받기 쉬운|민감한|감염되기 쉬운',
      	suspend: '중단하다|정지하다|…을 연기하다|달다|지연되다',
      	sustain: '지속하다|부상을 입다|지탱하다|견디다|지지하다',
      	synthesis: '종합|통합|합성',
      	tactful: '재치 있는|약삭빠른|적절한',
      	tactics: '전술|전략|방법|작전|정책',
      	tactile: '촉각의|촉각으로 알 수 있는|촉지할 수 있는',
      	tangible: '유형의|만져서 알 수 있는|명백한',
      	tardy: '느린|지각한|늦은',
      	tempt: '유혹하다|하고 싶은|끌다|꾀다',
      	tenable: '지지할 수 있는|공격에 견디는|방어할 수 있는',
      	tenacious: '집요한|끈질긴|고집하는',
      	tenet: '주의|교의|견해',
      	testify: '증언하다|표명하다|증명하다',
      	thesis: '논문|주제',
      	tolerate: '참다|견디다|내성이 있다',
      	touchy: '과민한|다루기 어려운|타기 쉬운',
      	transaction: '거래|트랜잭션|계약|업무|입출금',
      	transfer: '넘겨주다|옮기다|갈아타다|바꾸다|물려주다',
      	transgress: '어기다|위반하다|넘다',
      	transient: '덧없는|일시적인|잠깐 머무르는',
      	transitory: '일시적인|덧없는|오래가지 않는',
      	transportation: '교통|운송',
      	traverse: '횡단하다|가로지르다|횡단',
      	trespass: '침입하다|침해하다|죄를 범하다|폐를 끼치다',
      	turbid: '탁한|자욱한|혼란된',
      	turbulent: '사나운|폭풍우의|험한',
      	turmoil: '소란|혼란|소동',
      	typify: '…을 대표하다|…의 특징을 나타내다|…의 전형이 되다',
      	unassuming: '주제넘지 않는|젠체하지 않는|겸손한',
      	unbridled: '말굴레를 매지 않은|억제되지 않은|구속이 없는',
      	uniform: '유니폼|똑같은|일제히',
      	unprecedented: '전례 없는|유례없는|엄청난|이례적',
      	unravel: '풀다|…을 해명하다|해결하다',
      	upset: '화난|기분 나쁜|당황|혼란|아픈',
      	urgent: '긴급한|급박한|긴박한|절박한|다급한',
      	variety: '다양|여러종류|여러 가지|버라이어티|갖가지',
      	veer: '…의 방향을 바꾸다|바뀌다|방향이 바뀌다',
      	velocity: '속도',
      	vent: '배출구|분출하다|분노|분화구|화풀이',
      	verge: '가장자리|경계|변두리',
      	versatile: '다재 다능한|다용도의|다목적|다양한|다기능',
      	versed: '숙달한|정통한',
      	vice: 'versa	거꾸로|반대로|반대의 경우도 마찬가지',
      	vicinity: '주변|인근|가까이',
      	vicissitude: '변천|변화|부침',
      	vociferous: '큰 소리로 외치는|떠들썩한|시끄러운',
      	yield: '수확|항복|수율|수익|수익률'
    }
    
    
    hint = wordList.to_a.sample(1).to_h.values[0]
    word = wordList.to_a.sample(1).to_h.keys[0]
    
    redirect_to :controller => 'game', :action => 'game', :hint => hint, :word => word, :cnt => -1
  end
end

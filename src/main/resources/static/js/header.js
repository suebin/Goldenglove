//모바일 메뉴 버튼
const mobileBtn = document.querySelector('.mobileBtn');
const mobileBtnBar = document.querySelectorAll('.mobileBtn span');
const headerBar = document.querySelector('header > .confix');
const dropdownBtn = document.querySelector('.dropdownBtn');
const dropdownCon = document.querySelector('.dropdown-contents');


// 웹 실행 시 바로 함수 실행
showMobileMenu();
mobileDropDown();


// 웹 화면 사이즈 조절 시 함수 실행
let timer = null;

$(window).on('resize', function () {
  clearTimeout(timer);
  
  // 0.3초 후 resize 확인
  timer = setTimeout(() => {
	  showMobileMenu();
	  mobileDropDown();	
  }, 300);
});


// 모바일 메뉴 버튼 누르면 메뉴 보임
function showMobileMenu() {
	if (window.innerWidth <= 768) {
		headerBar.style.height = '55px';
		
		mobileBtn.onclick = () => {
		    mobileBtnBar[0].classList.toggle('hidden');
		    mobileBtnBar[1].classList.toggle('rotate');
		    mobileBtnBar[1].classList.toggle('closeBar');
		    mobileBtnBar[2].classList.toggle('hidden');
		
		    if (mobileBtnBar[0].classList.contains('hidden')) {
		    	headerBar.style.height = '280px';
		    	
		    } else if (!mobileBtnBar[0].classList.contains('hidden')) {
		    	headerBar.style.height = '55px';
		    }
		}
	} else {
		headerBar.style.height = '80px';
	}
}


// 아이디에 마우스 올리면 내 정보 관련 메뉴 나옴
function mobileDropDown() {
	if (window.innerWidth <= 768) {
    	dropdownBtn.addEventListener('mouseover', openDropDown);
    	dropdownCon.addEventListener('mouseleave', closeDropDown);
	} else {
		dropdownBtn.removeEventListener('mouseover', openDropDown);
		dropdownCon.removeEventListener('mouseleave', closeDropDown);
	}
}

// 내 정보 관련 메뉴 보임
function openDropDown() {
	if (headerBar.style.height = '280px') {
    	headerBar.style.height = '390px';
    } 
}

// 내 정보 관련 메뉴 숨김
function closeDropDown() {
	if (headerBar.style.height = '390px') {
    	headerBar.style.height = '280px';
    } 
}
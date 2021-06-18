	const searchInput = document.getElementById('txtSearch2');
	const rows = document.querySelectorAll('tbody tr');
	
	//console.log(rows);
	searchInput.addEventListener('keyup', function(event){
	//console.log(event);
		const q = event.target.value.toLowerCase();
	rows.forEach(row => {
		//console.log(row);	
		row.querySelector('td').textContent.toLowerCase().startsWith(q) ? (row.style.display = "") : (row.style.display = "none");
						});
		});
		
	
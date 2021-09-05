// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SpawnEnemy(m_enemyRef, m_unitName, m_unitLevel){
	var m_count = 1;
	
	for (var i = 0; i < instance_number(objEnemy); i++)  {
		var m_nameCheck = instance_find(objEnemy, i).unitParam[UnitParameters.Name];
		if (string_pos(m_unitName, m_nameCheck) > 0) {
			m_count++;
		}
	}
	
	m_enemyRef.unitParam[UnitParameters.Name] = m_unitName + " " + NumToAlpha(m_count);
	m_enemyRef.unitParam[UnitParameters.Level] = m_unitLevel;
	switch (m_unitName) {
	    case "Walking Armor":
			m_enemyRef.unitParam[UnitParameters.TotalHP] = 10 + (m_unitLevel * 5);
			m_enemyRef.unitParam[UnitParameters.CurrentHP] = m_enemyRef.unitParam[UnitParameters.TotalHP];
			m_enemyRef.unitParam[UnitParameters.Attack] = 3 + (m_unitLevel * 1);
			m_enemyRef.unitParam[UnitParameters.Defense] = 1 + (m_unitLevel * 1);
			m_enemyRef.unitParam[UnitParameters.Speed] = 1 + (m_unitLevel * 1);
			m_enemyRef.unitParam[UnitParameters.StatusEffect] = Status.None;
	        break;
	    case "Wisp":
			m_enemyRef.unitParam[UnitParameters.TotalHP] = 3 + (m_unitLevel * 2);
			m_enemyRef.unitParam[UnitParameters.CurrentHP] = m_enemyRef.unitParam[UnitParameters.TotalHP];
			m_enemyRef.unitParam[UnitParameters.Attack] = 5 + (m_unitLevel * 2);
			m_enemyRef.unitParam[UnitParameters.Defense] = ((m_unitLevel div 5) * 2);
			m_enemyRef.unitParam[UnitParameters.Speed] = 1 + (m_unitLevel * 1);
			m_enemyRef.unitParam[UnitParameters.StatusEffect] = Status.None;
	        break;
	    default:
	        // code here
	        break;
	}
}
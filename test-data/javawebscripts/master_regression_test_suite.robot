*** Settings ***
Library		OperatingSystem
Library		regression_lib.py
Suite Setup		parse_command_line

*** Variables ***
${evaluate_only}		set_true

*** Test Cases ***

PostSite
	[Documentation]		"Regression Test: 10. Create a project and site"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostElementsNew
	[Documentation]		"Regression Test: 20. Post elements to the master branch"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 20
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostElementsBadOwners
	[Documentation]		"Regression Test: 21. Post elements to the master branch that have owners that cant be found"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 21
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostMultiplicityRedefines
	[Documentation]		"Regression Test: 22. Post elements to the master branch that exercise the multiplicity and redefines attributes of a Property"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 22
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostViews
	[Documentation]		"Regression Test: 30. Post views"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 30
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostProducts
	[Documentation]		"Regression Test: 40. Post products"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 40
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetSites
	[Documentation]		"Regression Test: 45. Get sites"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 45
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetProject
	[Documentation]		"Regression Test: 50. Get project"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 50
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetProjects
	[Documentation]		"Regression Test: 51. Get all projects for master"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 51
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetElementsRecursively
	[Documentation]		"Regression Test: 60. Get all elements recursively"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 60
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetElementsDepth0
	[Documentation]		"Regression Test: 61. Get elements recursively depth 0"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 61
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetElementsDepth1
	[Documentation]		"Regression Test: 62. Get elements recursively depth 1"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 62
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetElementsDepth2
	[Documentation]		"Regression Test: 63. Get elements recursively depth 2"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 63
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetElementsDepthAll
	[Documentation]		"Regression Test: 64. Get elements recursively depth -1"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 64
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetElementsDepthInvalid
	[Documentation]		"Regression Test: 65. Get elements recursively depth invalid"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 65
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetElementsConnected
	[Documentation]		"Regression Test: 66. Get elements that are connected"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 66
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetElementsRelationship
	[Documentation]		"Regression Test: 67. Get elements that have relationship DirectedRelationship, starting with 302"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 67
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetElements
	[Documentation]		"Regression Test: 68. Get elements using body to specify elements"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 68
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PutElements
	[Documentation]		"Regression Test: 69. Get elements using body to specify elements"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 69
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetViews
	[Documentation]		"Regression Test: 70. Get views"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 70
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetViewElements
	[Documentation]		"Regression Test: 80. Get view elements"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 80
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetProducts
	[Documentation]		"Regression Test: 90. Get product"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 90
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetSearch
	[Documentation]		"Regression Test: 110. Get search"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 110
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

Delete6666
	[Documentation]		"Regression Test: 120. Delete element 6666"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 120
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostChange
	[Documentation]		"Regression Test: 130. Post changes to directed relationships only (without owners)"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 130
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostConfig
	[Documentation]		"Regression Test: 140. Post configuration"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 140
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetConfig
	[Documentation]		"Regression Test: 150. Get configurations"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 150
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostConfigAgain
	[Documentation]		"Regression Test: 154. Post same configuration again"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 154
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetConfigAgain
	[Documentation]		"Regression Test: 155. Get configurations"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 155
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateWorkspace1
	[Documentation]		"Regression Test: 160. Create workspace test 1"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 160
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostProjectWorkspace1
	[Documentation]		"Regression Test: 161. Post project to sync branch version for workspace 1"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 161
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateWorkspace2
	[Documentation]		"Regression Test: 162. Create workspace test 2"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 162
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostProjectWorkspace2
	[Documentation]		"Regression Test: 163. Post project to sync branch version for workspace 2 - sub workspace"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 163
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateWorkspaceWithJson
	[Documentation]		"Regression Test: 164. Create a workspace using a json"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 164
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

ModifyWorkspaceWithJson
	[Documentation]		"Regression Test: 165. Modifies a workspace name/description"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 165
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetWorkspaces
	[Documentation]		"Regression Test: 166. Get workspaces"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 166
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToWorkspace
	[Documentation]		"Regression Test: 167. Post element to workspace"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 167
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesForMerge
	[Documentation]		"Regression Test: 168. Compare workspaces for a merge of the second into the first"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 168
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspaces
	[Documentation]		"Regression Test: 168.5. Compare workspaces"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 168.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesForMergeBackground1
	[Documentation]		"Regression Test: 169. Compare workspaces for a merge in the background, this will return that it is in process"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 169
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesBackground1
	[Documentation]		"Regression Test: 169.5. Compare workspaces in the background, this will return that it is in process"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 169.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesBackground2
	[Documentation]		"Regression Test: 170. Compare workspaces in the background again, this will return the results of the background diff"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 170
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesBackground2
	[Documentation]		"Regression Test: 170.5. Compare workspaces in the background again, this will return the results of the background diff"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 170.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesGlomForMerge1
	[Documentation]		"Regression Test: 171. Compare workspaces for a merge where there is a initial background diff stored"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 171
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesGlom1
	[Documentation]		"Regression Test: 171.5. Compare workspaces where there is a initial background diff stored"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 171.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToWorkspaceForGlom
	[Documentation]		"Regression Test: 172. Post element to workspace"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 172
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesGlomForMerge2
	[Documentation]		"Regression Test: 173. Compare workspaces for a merge where there is a initial background diff stored and a change has been made since then."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 173
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesGlom2
	[Documentation]		"Regression Test: 173.5. Compare workspaces where there is a initial background diff stored and a change has been made since then."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 173.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateWorkspaceWithBranchTime
	[Documentation]		"Regression Test: 174. Create workspace with a branch time"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 174
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToWorkspaceWithBranchTime
	[Documentation]		"Regression Test: 175. Post element to workspace with a branch time"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 175
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToWorkspaceForConflict1
	[Documentation]		"Regression Test: 176. Post element to workspace1 so that we get a conflict"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 176
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToWorkspaceForConflict2
	[Documentation]		"Regression Test: 177. Post element to workspace with a branch time so that we get a conflict"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 177
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToWorkspaceForMoved
	[Documentation]		"Regression Test: 178. Post element to workspace with a branch time so that we get a moved element"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 178
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToWorkspaceForTypeChange
	[Documentation]		"Regression Test: 179. Post element to workspace with a branch time so that we get a type change"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 179
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToWorkspaceForWs1Change
	[Documentation]		"Regression Test: 180. Post element to workspace1 so that we dont detect it in the branch workspace.  Changes 303"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 180
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetElement303
	[Documentation]		"Regression Test: 181. Get element 303"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 181
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesWithBranchTimeForMerge
	[Documentation]		"Regression Test: 182. Compare workspaces with branch times for a merge"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 182
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesWithBranchTime
	[Documentation]		"Regression Test: 182.5. Compare workspaces"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 182.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToWorkspace3
	[Documentation]		"Regression Test: 183. Post element z to workspace"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 183
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateWorkspaceWithBranchTime2
	[Documentation]		"Regression Test: 184. Create workspace with a branch time using the current time for the branch time"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 184
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesWithBranchTimesForMerge
	[Documentation]		"Regression Test: 185. Compare workspaces each of which with a branch time and with a modified element on the common parent for a merge"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 185
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesWithBranchTimes
	[Documentation]		"Regression Test: 185.5. Compare workspaces both which have a branch time and with a modified element on the common parent"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 185.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesForMergeBackgroundOutdated
	[Documentation]		"Regression Test: 186. Compare workspaces for a merge in the background, this will return that it is outdated"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 186
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesBackgroundOutdated
	[Documentation]		"Regression Test: 186.5. Compare workspaces in the background, this will return that it is outdated"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 186.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesForMergeBackgroundRecalculate
	[Documentation]		"Regression Test: 187. Compare workspaces for a merge in the background, and forces a recalculate on a outdated diff"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 187
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesBackgroundRecalculate
	[Documentation]		"Regression Test: 187.5. Compare workspaces in the background, and forces a recalculate on a outdated diff"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 187.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateWorkspaceAgain1
	[Documentation]		"Regression Test: 188. Create workspace for another diff test"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 188
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateWorkspaceAgain2
	[Documentation]		"Regression Test: 189. Create workspace for another diff test"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 189
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToWorkspaceG1ForCMED533
	[Documentation]		"Regression Test: 190. Post elements to workspace wsG1 for testing CMED-533"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 190
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToWorkspaceG1
	[Documentation]		"Regression Test: 191. Post element to workspace wsG1"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 191
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToMaster
	[Documentation]		"Regression Test: 192. Post element to master for a later diff"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 192
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToWorkspaceG2ForCMED533
	[Documentation]		"Regression Test: 193. Post elements to workspace wsG2 for testing CMED-533"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 193
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToWorkspaceG2
	[Documentation]		"Regression Test: 194. Post element to workspace wsG2"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 194
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesG1G2ForMerge
	[Documentation]		"Regression Test: 195. Compare workspaces wsG1 and wsG2 with timestamps for a merge"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 195
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesG1G2
	[Documentation]		"Regression Test: 195.5. Compare workspaces wsG1 and wsG2 with timestamps"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 195.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesG1G2ForMergeBackground
	[Documentation]		"Regression Test: 196. Compare workspaces wsG1 and wsG2 with timestamps for a merge in the background to set up a initial diff for the next test"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 196
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesG1G2Background
	[Documentation]		"Regression Test: 196.5. Compare workspaces wsG1 and wsG2 with timestamps in background to set up a initial diff for the next test"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 196.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesG1G2ForMergeGlom
	[Documentation]		"Regression Test: 197. Compare workspaces wsG1 and wsG2 with timestamps for a merge with an initial diff"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 197
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesG1G2Glom
	[Documentation]		"Regression Test: 197.5. Compare workspaces wsG1 and wsG2 with timestamps with a initial diff"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 197.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

RecursiveGetOnWorkspaces
	[Documentation]		"Regression Test: 198. Makes sure that a recursive get on a modified workspace returns the modified elements"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 198
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostSiteInWorkspace
	[Documentation]		"Regression Test: 199. Create a project and site in a workspace"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 199
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetSiteInWorkspace
	[Documentation]		"Regression Test: 200. Get site in workspace"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 200
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetProductsInSiteInWorkspace
	[Documentation]		"Regression Test: 201. Get products for a site in a workspace"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 201
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostNotInPastToWorkspace
	[Documentation]		"Regression Test: 202. Post element to master workspace for a diff test"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 202
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesForMergeNotInPast
	[Documentation]		"Regression Test: 203. Compare workspace master with itself for a merge at the current time and a time in the past"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 203
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesNotInPast
	[Documentation]		"Regression Test: 203.5. Compare workspace master with itself at the current time and a time in the past"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 203.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesForMergeNotInPastBackground
	[Documentation]		"Regression Test: 204. Compare workspace master with itself for a merge at the current time and a time in the past in the background"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 204
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesNotInPastBackground
	[Documentation]		"Regression Test: 204.5. Compare workspace master with itself at the current time and a time in the past in the background"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 204.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateParentWorkspace
	[Documentation]		"Regression Test: 205. Create a workspace to be a parent of another"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 205
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToMasterAgain
	[Documentation]		"Regression Test: 206. Post new element to master"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 206
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateSubworkspace
	[Documentation]		"Regression Test: 207. Create workspace inside a workspace"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 207
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetElementInMasterFromSubworkspace
	[Documentation]		"Regression Test: 208. Get an element that only exists in the master from a subworkspace after its parent branch was created but before the it was created, it wont find the element"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 208
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostAToMaster
	[Documentation]		"Regression Test: 209. Post element a to master."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 209
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateAParentWorkspace
	[Documentation]		"Regression Test: 210. Create a "parent" workspace off of master.."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 210
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostBToMaster
	[Documentation]		"Regression Test: 211. Post element b to master."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 211
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostCToParent
	[Documentation]		"Regression Test: 212. Post element c to the parent workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 212
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateASubWorkspace
	[Documentation]		"Regression Test: 213. Create a "subworkspace" workspace off of the parent."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 213
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostDToMaster
	[Documentation]		"Regression Test: 214. Post element d to master."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 214
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostEToParent
	[Documentation]		"Regression Test: 215. Post element e to the parent workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 215
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostFToSubworkspace
	[Documentation]		"Regression Test: 216. Post element f to the subworkspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 216
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetAInMaster
	[Documentation]		"Regression Test: 217. Get element a in the master workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 217
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetAInParent
	[Documentation]		"Regression Test: 218. Get element a in the parent workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 218
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetAInSubworkspace
	[Documentation]		"Regression Test: 219. Get element a in the subworkspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 219
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetBInMaster
	[Documentation]		"Regression Test: 220. Get element b in the master workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 220
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetBInParent
	[Documentation]		"Regression Test: 221. Get element b in the parent workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 221
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetBInSubworkspace
	[Documentation]		"Regression Test: 222. Get element b in the subworkspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 222
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetCInMaster
	[Documentation]		"Regression Test: 223. Get element c in the master workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 223
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetCInParent
	[Documentation]		"Regression Test: 224. Get element c in the parent workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 224
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetCInSubworkspace
	[Documentation]		"Regression Test: 225. Get element c in the subworkspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 225
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetDInMaster
	[Documentation]		"Regression Test: 226. Get element d in the master workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 226
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetDInParent
	[Documentation]		"Regression Test: 227. Get element d in the parent workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 227
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetDInSubworkspace
	[Documentation]		"Regression Test: 228. Get element d in the subworkspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 228
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetEInMaster
	[Documentation]		"Regression Test: 229. Get element e in the master workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 229
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetEInParent
	[Documentation]		"Regression Test: 230. Get element e in the parent workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 230
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetEInSubworkspace
	[Documentation]		"Regression Test: 231. Get element e in the subworkspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 231
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetFInMaster
	[Documentation]		"Regression Test: 232. Get element f in the master workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 232
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetFInParent
	[Documentation]		"Regression Test: 233. Get element f in the parent workspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 233
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetFInSubworkspace
	[Documentation]		"Regression Test: 234. Get element f in the subworkspace."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 234
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TurnOnExpressionStuff
	[Documentation]		"Regression Test: 254. Make sure switch is turned on for handling expressions in viewpoints, etc."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 254
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

SolveConstraint
	[Documentation]		"Regression Test: 255. Post expressions with a constraint and solve for the constraint."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 255
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostDemo1
	[Documentation]		"Regression Test: 260. Post data for demo 1 of server side docgen"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 260
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

Demo1
	[Documentation]		"Regression Test: 270. Server side docgen demo 1"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 270
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

Demo1Contents
	[Documentation]		"Regression Test: 271. Server side docgen demo 1 with instance specifications"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 271
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostDemo1_postcond
	[Documentation]		"Regression Test: 272. Post data for demo 1 with postcondition"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 272
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

Demo1_postcond
	[Documentation]		"Regression Test: 274. Server side docgen demo 1 with postcondition"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 274
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostDemo2
	[Documentation]		"Regression Test: 280. Post data for demo 2 of server side docgen"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 280
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

Demo2
	[Documentation]		"Regression Test: 290. Server side docgen demo 2"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 290
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

Demo2Contents
	[Documentation]		"Regression Test: 291. Server side docgen demo 2 with instance specifications"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 291
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostSiteAndProject3
	[Documentation]		"Regression Test: 292. Create a site and a project for demo 3 of server side docgen"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 292
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostDemo3
	[Documentation]		"Regression Test: 293. Post data for demo 3 of server side docgen"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 293
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostViewDemo3
	[Documentation]		"Regression Test: 294. Post view data for demo 3 of server side docgen"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 294
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

Demo3
	[Documentation]		"Regression Test: 295. Server side docgen demo 3"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 295
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

Demo3Contents
	[Documentation]		"Regression Test: 296. Server side docgen demo 3 with instance specifications"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 296
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TurnOffExpressionStuff
	[Documentation]		"Regression Test: 297. Make sure switch is turned off for handling expressions in viewpoints, etc."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 297
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetSites2
	[Documentation]		"Regression Test: 300. Get all the sites for a workspace"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 300
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetProductViews
	[Documentation]		"Regression Test: 310. Get all views for a product"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 310
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostElementX
	[Documentation]		"Regression Test: 320. Post element to the master branch/site"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 320
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

UpdateProject
	[Documentation]		"Regression Test: 330. Update a project"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 330
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetProjectOnly
	[Documentation]		"Regression Test: 340. Get project w/o specifying the site"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 340
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostArtifact
	[Documentation]		"Regression Test: 350. Post artifact to the master branch"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 350
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetArtifact
	[Documentation]		"Regression Test: 360. Get artifact from the master branch"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 360
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateWorkspaceDelete1
	[Documentation]		"Regression Test: 370. Create workspace to be deleted"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 370
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateWorkspaceDelete2
	[Documentation]		"Regression Test: 380. Create workspace to be deleted"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 380
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteWorkspace
	[Documentation]		"Regression Test: 390. Delete workspace and its children"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 390
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CheckDeleted2
	[Documentation]		"Regression Test: 410. Make sure that AA and its children show up in deleted"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 410
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

UnDeleteWorkspace
	[Documentation]		"Regression Test: 420. Undelete workspace"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 420
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostContentModelUpdates
	[Documentation]		"Regression Test: 460. Post content model udpates for sysml 2.0"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 460
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostDuplicateSysmlNames1
	[Documentation]		"Regression Test: 470. Post a element that will be used in the next test to generate a error"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 470
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostModelForDowngrade
	[Documentation]		"Regression Test: 500. Post model for downgrade test"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 500
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostModelForViewDowngrade
	[Documentation]		"Regression Test: 510. Post model for view downgrade"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 510
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostModelForElementDowngrade
	[Documentation]		"Regression Test: 520. Post model for element downgrade"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 520
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DiffWorkspaceCreate1
	[Documentation]		"Regression Test: 530. Diff Workspace Test - Create WS 1"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 530
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DiffWorkspaceCreate2
	[Documentation]		"Regression Test: 540. Diff Workspace Test - Create WS 2"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 540
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DiffPostToWorkspace1
	[Documentation]		"Regression Test: 560. Diff Workspace Test - Post element to workspace"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 560
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DiffUpdateElement402
	[Documentation]		"Regression Test: 570. Diff Workspace Test - Update element 402"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 570
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DiffCompareWorkspacesForMerge
	[Documentation]		"Regression Test: 580. Diff Workspace Test - Compare workspaces for a merge"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 580
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DiffCompareWorkspaces
	[Documentation]		"Regression Test: 580.5. Diff Workspace Test - Compare workspaces"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 580.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostDiff
	[Documentation]		"Regression Test: 581. Post a diff to merge workspaces"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 581
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DiffCompareWorkspacesAgainForMerge
	[Documentation]		"Regression Test: 582. Diff Workspace Test - Compare workspaces again for a merge and make sure the diff is empty now after merging."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 582
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DiffCompareWorkspacesAgain
	[Documentation]		"Regression Test: 582.5. Diff Workspace Test - Compare workspaces again and make sure the diff is empty now after merging."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 582.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

ParseSimpleExpression
	[Documentation]		"Regression Test: 600. Parse "1 + 1" from URL and create expression elements"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 600
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

ParseAndEvaluateTextExpressionInFile
	[Documentation]		"Regression Test: 601. Parse text expression in file, create expression elements for it, and then evaluate the expression elements"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 601
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateCollaborator
	[Documentation]		"Regression Test: 610. Create Collaborator user for europa"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 610
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateContributor
	[Documentation]		"Regression Test: 611. Create Contributor user for europa"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 611
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateConsumer
	[Documentation]		"Regression Test: 612. Create Consumer user for europa"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 612
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateManager
	[Documentation]		"Regression Test: 613. Create Manager user for europa"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 613
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateNone
	[Documentation]		"Regression Test: 614. Create user with no europa priveleges"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 614
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

NoneRead
	[Documentation]		"Regression Test: 620. Read element with user None"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 620
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

NoneDelete
	[Documentation]		"Regression Test: 621. Delete element with user None"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 621
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CollaboratorUpdate
	[Documentation]		"Regression Test: 625. Update element with user Collaborator"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 625
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CollaboratorResurrect
	[Documentation]		"Regression Test: 628. Resurrect element with user Collaborator"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 628
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

ConsumerCreate
	[Documentation]		"Regression Test: 632. Create element with user Consumer"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 632
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

ConsumerDelete
	[Documentation]		"Regression Test: 633. Delete element with user Consumer"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 633
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

ConsumerResurrect
	[Documentation]		"Regression Test: 634. Resurrect element with user Consumer"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 634
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostNullElements
	[Documentation]		"Regression Test: 640. Post elements to the master branch with null properties"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 640
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestJsonCache1
	[Documentation]		"Regression Test: 650. Post elements for json cache testing."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 650
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestJsonCache2
	[Documentation]		"Regression Test: 651. Post elements for json cache testing."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 651
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestJsonCache3
	[Documentation]		"Regression Test: 652. Post elements for json cache testing."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 652
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestJsonCache4
	[Documentation]		"Regression Test: 653. Post elements for json cache testing."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 653
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestResurrection1
	[Documentation]		"Regression Test: 660. Post elements for resurrection of parents testing.  Has two parents that will be resurrected."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 660
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteParents
	[Documentation]		"Regression Test: 661. Delete parents"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 661
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestResurrection2
	[Documentation]		"Regression Test: 662. Post elements for resurrection of parents testing.  Has two parents that will be resurrected."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 662
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestGetAfterResurrection
	[Documentation]		"Regression Test: 663. Performs a recursive get to make sure the ownedChildren were properly set after resurrection."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 663
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostElementsWithProperites
	[Documentation]		"Regression Test: 670. Post elements for the next several tests"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 670
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetSearchSlotProperty
	[Documentation]		"Regression Test: 671. Searching for the property "real" having value 5.39 (slot property)"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 671
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetSearchSlotPropertyOffNom
	[Documentation]		"Regression Test: 672. Searching for the property "foo" having value 5.39 (slot property).  This should fail"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 672
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetSearchNonSlotProperty
	[Documentation]		"Regression Test: 673. Searching for the property "real55" having value 34.5 (non-slot property)"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 673
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetSearchNonSlotPropertyOffNom
	[Documentation]		"Regression Test: 674. Searching for the property "real55" having value 34.5 (non-slot property).  This should fail."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 674
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetSearchElementWithProperty
	[Documentation]		"Regression Test: 675. Searching for element that owns a Property"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 675
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostElementsForAspectHistoryCheck
	[Documentation]		"Regression Test: 700. Post elements to check for aspect changes in version history"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 700
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CheckIfPostedAspectsInHistory
	[Documentation]		"Regression Test: 701. Get the previously posted elements at timestamp=now to see if their type aspects were recorded properly."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 701
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteElementForAspectHistoryCheck
	[Documentation]		"Regression Test: 702. Delete a property to see if the Delete aspect is recorded in the version history"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 702
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

UpdateElementsForAspectHistoryCheck
	[Documentation]		"Regression Test: 703. Post updates to element types to check for aspect changes in version history"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 703
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CheckIfAspectUpdatesInHistory
	[Documentation]		"Regression Test: 704. Get the previously updated elements at timestamp=now to see if changes to their type aspects were recorded properly."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 704
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CheckIfAspectDeleteInHistory
	[Documentation]		"Regression Test: 705. Get the previously deleted element at timestamp=now to see if the Deleted aspect was recorded properly."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 705
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostElementsMatrix1
	[Documentation]		"Regression Test: 800. Post elements to the master branch for glom matrix testing"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 800
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateWorkspaceMatrixTest1
	[Documentation]		"Regression Test: 801. Create workspace1 for glom matrix testing"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 801
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteDeleteAddWsMatrix1
	[Documentation]		"Regression Test: 802. Delete delete_add_gg"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 802
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteDeleteUpdateWsMatrix1
	[Documentation]		"Regression Test: 803. Delete delete_update_gg"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 803
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteDeleteDeleteWsMatrix1
	[Documentation]		"Regression Test: 804. Delete delete_delete_gg"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 804
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteDeleteNoneWsMatrix1
	[Documentation]		"Regression Test: 805. Delete delete_none_gg"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 805
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostElementsWsMatrix1
	[Documentation]		"Regression Test: 806. Post elements to the wsMatrix1 branch for glom matrix testing"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 806
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteUpdateAddMaster
	[Documentation]		"Regression Test: 807. Delete update_add_gg"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 807
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteDeleteAddMaster
	[Documentation]		"Regression Test: 808. Delete delete_add_gg"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 808
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostElementsMatrix2
	[Documentation]		"Regression Test: 809. Post elements to the master branch for glom matrix testing"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 809
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateWorkspaceMatrixTest2
	[Documentation]		"Regression Test: 810. Create workspace2 for glom matrix testing"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 810
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteAddDeleteWsMatrix2
	[Documentation]		"Regression Test: 811. Delete add_delete_gg"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 811
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteUpdateDeleteWsMatrix2
	[Documentation]		"Regression Test: 812. Delete update_delete_gg"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 812
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteDeleteDeleteWsMatrix2
	[Documentation]		"Regression Test: 813. Delete delete_delete_gg"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 813
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteNoneDeleteWsMatrix2
	[Documentation]		"Regression Test: 814. Delete none_delete_gg"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 814
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostElementsWsMatrix2
	[Documentation]		"Regression Test: 815. Post elements to the wsMatrix2 branch for glom matrix testing"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 815
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesGlomMatrixForMerge
	[Documentation]		"Regression Test: 816. Compare workspaces at latest times for glom matrix test.  Does merge style diff."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 816
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesGlomMatrix
	[Documentation]		"Regression Test: 817. Compare workspaces at latest times for glom matrix test.  Does full compare style diff."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 817
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostElementsMerge1
	[Documentation]		"Regression Test: 900. Post elements to the master branch for merge-style diff testing"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 900
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteDeleteDeleteBeforeMasterMerge1
	[Documentation]		"Regression Test: 900.5. Delete delete_delete_before"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 900.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CreateWorkspaceMerge-style-Test1
	[Documentation]		"Regression Test: 901. Create workspace1 for merge-style diff testing"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 901
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteDeleteDeleteMasterMerge1
	[Documentation]		"Regression Test: 902. Delete delete_delete_consistent"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 902
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteDeleteUpdateMasterMerge1
	[Documentation]		"Regression Test: 903. Delete delete_update_consistent"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 903
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostElementsMasterMerge1
	[Documentation]		"Regression Test: 904. Post elements to the MasterMerge1 branch for merge-style diff testing"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 904
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesForMerge-style1
	[Documentation]		"Regression Test: 905. Compare workspaces at latest times for merge-style diff test."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 905
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesForMerge-style2
	[Documentation]		"Regression Test: 905.5. Compare workspaces at latest times for merge-style diff test."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 905.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteDeleteDeleteWs1
	[Documentation]		"Regression Test: 906. Delete delete_delete_consistent"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 906
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteUpdateDeleteWs1
	[Documentation]		"Regression Test: 907. Delete update_delete_consistent"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 907
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteAddAddBeforeWs1
	[Documentation]		"Regression Test: 907.5. Delete add_add_before"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 907.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostElementsMerge2
	[Documentation]		"Regression Test: 908. Post elements to the master branch for merge-style diff testing"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 908
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteNoneAddDeleteWs1
	[Documentation]		"Regression Test: 908.2. Delete none_add_delete"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 908.2
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

DeleteDeleteDeleteBeforeWs1
	[Documentation]		"Regression Test: 908.5. Delete delete_delete_before"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 908.5
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesForMerge-style3
	[Documentation]		"Regression Test: 909. Compare workspaces at latest times for merge-style diff test."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 909
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

CompareWorkspacesForMerge-style4
	[Documentation]		"Regression Test: 910. Compare workspaces at latest times for merge-style diff test."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 910
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetSearchDocumentation
	[Documentation]		"Regression Test: 10000. Get search documentation"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10000
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetSearchAspects
	[Documentation]		"Regression Test: 10001. Get search aspects"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10001
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetSearchId
	[Documentation]		"Regression Test: 10002. Get search id"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10002
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetNodeRefHistory
	[Documentation]		"Regression Test: 10004. Get NodeRef History"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10004
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TurnOnCheckMmsVersionFlag
	[Documentation]		"Regression Test: 10101. Turns on a service flag on the mms for comparing mms versions"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10101
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GET-CheckMmsVersion-Correct
	[Documentation]		"Regression Test: 10105. [ NOTE: GET Requests are currently allowed if versions do not match] Checks the MMS version when requesting an element, versions SHOULD match"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10105
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GET-CheckMmsVersion-Incorrect
	[Documentation]		"Regression Test: 10106. [ NOTE: GET Requests are currently allowed if versions do not match] Checks the MMS version when requesting an element, versions should NOT match"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10106
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GET-CheckMmsVersion-Missing-Argument
	[Documentation]		"Regression Test: 10108. [ NOTE: GET Requests are currently allowed if versions do not match] Checks the MMS version when requesting an element, request was made  but the REST call was missing the parameter '?mmsVersion=2.3'."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10108
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

POST-CheckMmsVersion-Correct
	[Documentation]		"Regression Test: 10109. Checks the MMS version when POSTing an element, versions SHOULD match"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10109
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

POST-CheckMmsVersion-Incorrect
	[Documentation]		"Regression Test: 10110. Checks the MMS version when POSTing an element, versions should NOT match"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10110
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

POST-CheckMmsVersion-Missing-Argument
	[Documentation]		"Regression Test: 10112. Checks the MMS version when POSTing an element, request was made  but the REST call was missing the parameter '?mmsVersion=2.3'."
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10112
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TurnOffCheckMmsVersionFlag
	[Documentation]		"Regression Test: 10120. Turns off a service flag on the mms"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10120
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

LogLevelPost
	[Documentation]		"Regression Test: 10129. Sets the log level of a class on mms"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10129
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestCase10130_PostElements
	[Documentation]		"Regression Test: 10130. Post elements"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10130
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestCase10130.1_VerifyProductX
	[Documentation]		"Regression Test: 10130.1. Verify elements for ProductX"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10130.1
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestCase10130.2_VerifyViewX
	[Documentation]		"Regression Test: 10130.2. Verify elements for View X"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10130.2
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestCase10130.3_VerifyViewY
	[Documentation]		"Regression Test: 10130.3. Verify elements for View Y"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10130.3
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestCase10130.4_VerifyViewZ
	[Documentation]		"Regression Test: 10130.4. Verify elements for View Z"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10130.4
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestCase10131_PostViewV
	[Documentation]		"Regression Test: 10131. Post view V"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10131
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestCase10132_PostViewVRemove
	[Documentation]		"Regression Test: 10132. Post view V"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10132
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

TestCase10133_PostViewVUpdate
	[Documentation]		"Regression Test: 10133. Post view V"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10133
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostPresentElemClassifiers
	[Documentation]		"Regression Test: 10134. posting job sysmlid and job stereotype ids"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10134
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostJobsBCDF
	[Documentation]		"Regression Test: 10135. post jobs B, C, D, F"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10135
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetJobsBCDF
	[Documentation]		"Regression Test: 10136. Change values of existing jobs"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10136
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostJobsAE_and_UpdateProperties
	[Documentation]		"Regression Test: 10137. Posting a single job without element json"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10137
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

VerifyUpdate
	[Documentation]		"Regression Test: 10138. Posting a job with no specified schedule"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10138
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostJobGwithProperties
	[Documentation]		"Regression Test: 10139. Obtaining the JSON for jobs contained by a view"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10139
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

GetJobG
	[Documentation]		"Regression Test: 10140. Obtaining the JSON for jobs contained by a view"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10140
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

PostToHoldingBin
	[Documentation]		"Regression Test: 10141. Post new element to holding bin"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10141
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

LoginTicketPost
	[Documentation]		"Regression Test: 10150. Get valid login ticket"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10150
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

LoginTicketGetValid
	[Documentation]		"Regression Test: 10151. Get ticket status for valid ticket"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10151
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

LoginTicketGetInvalid
	[Documentation]		"Regression Test: 10152. Get ticket status for invalid ticket"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10152
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

HierarchyTestPostSite
	[Documentation]		"Regression Test: 10200. Create a VE test project and site"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10200
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

HierarchyTestPost
	[Documentation]		"Regression Test: 10201. Post Hierarchy test project elements to the master branch"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10201
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

HierarchyTestPostConstraints
	[Documentation]		"Regression Test: 10202. Post Hierarchy test view constraints"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10202
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

HierarchyTestAddToC
	[Documentation]		"Regression Test: 10203. Hierarchy test adding to view c"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10203
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

HierarchyTestAddToA
	[Documentation]		"Regression Test: 10204. Hierarchy test adding to view A"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10204
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

HierarchyTestReorderB
	[Documentation]		"Regression Test: 10205. Hierarchy test reordering B"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10205
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

HierarchyTestMoveF
	[Documentation]		"Regression Test: 10206. Hierarchy test moving view F from view B to view D"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10206
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:

HierarchyTestDeleted
	[Documentation]		"Regression Test: 10207. Hierarchy test checking that the move deleted association and properties"
	${output}= 		 OperatingSystem.Run		./test-data/javawebscripts/regress.sh -v -g develop -t 10207
	log		 ${output}
	log to console		 ${output}
	Should Not Contain		${output}		FAIL:
	Should Contain			${output}		PASS:


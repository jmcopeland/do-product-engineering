# Validation Scoring System

This scoring framework helps teams make consistent go/no-go decisions for product and feature validation. Teams can customize weights and criteria to match their specific decision-making process.

## Scoring Criteria (1-5 Scale)

### Problem Severity (Default Weight: 25%)
**Measures**: How critical and frequent the problem is for users

- **5**: Critical pain point affecting users daily, significant impact on productivity/satisfaction
- **4**: Important problem affecting users multiple times per week, moderate impact
- **3**: Moderate inconvenience affecting users weekly, noticeable but manageable
- **2**: Minor issue affecting users occasionally, low impact on experience
- **1**: Nice-to-have improvement with minimal frequency or impact

**Assessment Factors**:
- Problem frequency (daily/weekly/monthly/rarely)
- Severity of impact when problem occurs
- Number of users affected
- Cost of current workarounds

### Solution Confidence (Default Weight: 25%)
**Measures**: How confident you are that the proposed solution addresses the problem effectively

- **5**: Proven solution with strong user validation, clear evidence of effectiveness
- **4**: Well-researched approach with some validation, high confidence in success
- **3**: Reasonable solution with logical basis, moderate confidence level
- **2**: Experimental approach with limited validation, significant uncertainty
- **1**: Unproven concept with high risk, low confidence in effectiveness

**Assessment Factors**:
- User feedback on proposed solution
- Market validation of similar approaches
- Technical feasibility and risks
- Uniqueness and competitive advantage

### Strategic Alignment (Default Weight: 20%)
**Measures**: How well this aligns with business strategy and goals

- **5**: Core to business strategy, critical for competitive positioning
- **4**: Strong strategic value, important for business objectives
- **3**: Good alignment with strategic goals, supports key initiatives
- **2**: Loose connection to strategy, minor strategic benefit
- **1**: Tangential to strategy, no clear strategic value

**Assessment Factors**:
- Connection to company mission/vision
- Impact on key business metrics
- Competitive advantage gained
- Long-term strategic value

### Resource Efficiency (Default Weight: 15%)
**Measures**: Effort-to-impact ratio and resource optimization

- **5**: Low effort, high impact - exceptional ROI
- **4**: Moderate effort, high impact - good ROI
- **3**: Balanced effort-to-impact ratio
- **2**: High effort, moderate impact - questionable ROI
- **1**: High effort, low impact - poor ROI

**Assessment Factors**:
- Development time and complexity
- Resource requirements (team, technology, budget)
- Opportunity cost vs. other initiatives
- Implementation and maintenance burden

### Market Opportunity (Default Weight: 15%)
**Measures**: Size and attractiveness of the market opportunity

- **5**: Large addressable market with strong growth potential
- **4**: Substantial market with good growth prospects
- **3**: Moderate market size with steady potential
- **2**: Small but viable market with limited growth
- **1**: Minimal market opportunity with little growth potential

**Assessment Factors**:
- Total addressable market size
- Market growth rate and trends
- Customer willingness to pay
- Competitive landscape density

## Scoring Calculation

**Formula**: `(Problem Severity × 0.25) + (Solution Confidence × 0.25) + (Strategic Alignment × 0.20) + (Resource Efficiency × 0.15) + (Market Opportunity × 0.15)`

**Example Calculation**:
```
Problem Severity:     4 × 25% = 1.00
Solution Confidence:  3 × 25% = 0.75
Strategic Alignment:  4 × 20% = 0.80
Resource Efficiency:  2 × 15% = 0.30
Market Opportunity:   3 × 15% = 0.45
                     ----------------
Final Score:                   3.30
```

## Decision Thresholds

### Strong Go (4.0 - 5.0)
- **Action**: Proceed with high confidence
- **Characteristics**: High scores across multiple criteria, strong validation
- **Risk Level**: Low - proceed to planning phase
- **Next Steps**: Begin detailed planning with `/do:plan`

### Conditional Go (3.0 - 3.9)
- **Action**: Proceed with caution and monitoring
- **Characteristics**: Mixed scores with some strong areas but notable concerns
- **Risk Level**: Medium - address concerns before or during development
- **Next Steps**: Identify mitigation strategies, consider additional validation

### Weak No (2.0 - 2.9)
- **Action**: Significant concerns, requires major improvements
- **Characteristics**: Multiple low scores indicating fundamental issues
- **Risk Level**: High - substantial changes needed
- **Next Steps**: Address major concerns, consider pivot or additional research

### Strong No (1.0 - 1.9)
- **Action**: Do not proceed with current approach
- **Characteristics**: Poor scores across criteria, high failure risk
- **Risk Level**: Very High - current approach not viable
- **Next Steps**: Pivot significantly, find new approach, or abandon

## Customization Guidelines

Teams can modify this scoring system by:

### Adjusting Weights
Edit the weight percentages to reflect your team's priorities:
```markdown
### Problem Severity (Weight: 30%)  # Increased for user-focused teams
### Solution Confidence (Weight: 30%)  # Increased for high-risk domains
### Strategic Alignment (Weight: 15%)  # Decreased for tactical teams
### Resource Efficiency (Weight: 15%)  # Standard for most teams
### Market Opportunity (Weight: 10%)  # Decreased for internal tools
```

### Adding Custom Criteria
Add additional criteria specific to your domain:
```markdown
### Regulatory Compliance (Weight: 10%)
- 5: Fully compliant, no regulatory risks
- 3: Minor compliance considerations
- 1: Major regulatory hurdles or risks
```

### Modifying Thresholds
Adjust decision thresholds for your risk tolerance:
```markdown
### Conservative Thresholds
- Strong Go: 4.2 - 5.0 (stricter requirements)
- Conditional Go: 3.5 - 4.1
- Weak No: 2.5 - 3.4
- Strong No: 1.0 - 2.4
```

## Usage Notes

- **Objectivity**: Base scores on evidence and data, not opinions
- **Consistency**: Use the same criteria across all validation decisions
- **Documentation**: Record rationale for each score assigned
- **Iteration**: Review and adjust scoring system based on outcomes
- **Transparency**: Share scoring rationale with stakeholders

## Validation Score Templates

### Product Validation Scoring Focus
- Emphasize Market Opportunity and Problem Severity
- Consider longer-term Strategic Alignment impact
- Weight Solution Confidence heavily due to product-market fit risk

### Feature Validation Scoring Focus
- Emphasize Resource Efficiency and Strategic Alignment
- Consider impact on existing user experience
- Weight Solution Confidence based on integration complexity
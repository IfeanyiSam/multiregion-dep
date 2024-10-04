resource "aws_cloudwatch_metric_alarm" "primary_alb_health" {
  provider            = aws.primary
  alarm_name          = "${var.environment}-primary-alb-health"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "gudlyf metric monitors the health of the primary ALB"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    LoadBalancer = var.primary_alb_arn
  }
}

resource "aws_cloudwatch_metric_alarm" "secondary_alb_health" {
  provider            = aws.secondary
  alarm_name          = "${var.environment}-secondary-alb-health"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "gudlyf metric monitors the health of the secondary ALB"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    LoadBalancer = var.secondary_alb_arn
  }
}

resource "aws_sns_topic" "alerts" {
  name = "${var.environment}-alerts"
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.environment}-multi-region-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HealthyHostCount", "LoadBalancer", var.primary_alb_arn],
            [".", "UnHealthyHostCount", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.primary_region
          title   = "Primary ALB Host Health"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HealthyHostCount", "LoadBalancer", var.secondary_alb_arn],
            [".", "UnHealthyHostCount", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.secondary_region
          title   = "Secondary ALB Host Health"
        }
      }
    ]
  })
}

Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21823278779;
	Mon, 30 Mar 2026 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774851030; cv=fail; b=aqYeXzJu7dxQVKxhF7daQ6BkkuEXCjuLSwkOPN9wnsWN9x0o5KWw449Sea74Hd/fj8eDqIHE2wnUvf8YR/6omPVjehv3DhgClSyMaGsf1ceT7vM38tiiYj7Pdb0wenb7BGw+ltoh/NhuKWQusWioPVSsS9ojiB3mgB+FwWkvM+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774851030; c=relaxed/simple;
	bh=yMNkCLroO7thTC0Vf54nA2Al7/+rhNf7j9ChIHcoWlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IEVknHXPEkb6/FOFeOgW0T+2iFuGVBSKignE4rBYsmMkVm9kHbAH5BlwLCyt8KupGp6xSCmeyD2uRyHQf27hP4uEoBUwR9pHyKbkcZTyyI3xjSz6cLYA1H9Umo/TEnGCxAbzpYq5N0fEBotylE1ykLngnkX4PgsRAJcpUttAths=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cLjvpuwa; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cLjvpuwa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFhLsAmEY5IWIXctdjosWIT5cNjwymHY35pn1mcN/qI6VFcrixLdiikifSWc1gxsWl7TBU0HqeMur7dnWu3YqrWXOqL+9kLIaFijFoJ0yHdsHfTGhG7sC0JS/13shbVTw+ilJeNZndGR0z9LNO5m60Vw4uNr6lTbb1vErM89VXmkRYfXGY5HFXo4plQAd50fpS7EcUL+4dTzIX1NH+m4OowLnF37vnJ0DgUuveDps99kqji5IQm5AauTb9xgii3u22Bu6XIsG3iUVYoAQjn2epU96HpUpvPu0Htlz799TVw2bEPt0vdBP/z8v6L72xXL6Mp/kgB3y/ksMIeHxyeDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGjB3n8Wbeo9L/gFr9msILVTrCs5sYyjgLgri5xBtJ4=;
 b=zIajQLdN5TFBCPmlH3l8EY63J43gIPYR8I96dbytqQIXu90KyMMvxy4ql9GtOObgz+80ztgWP+gjAc2Y0546gFgU6IM8MsctAz7T7/vV3qcvP77fcTyJYU/3rBsGpYlzHjhSdwEkSeED6AZ0CTUWxT9eVZFNW38wFsYdardWu0WI9RdQtRefnswch4G+YAy26pVIr5tT8TbQ/vzChjNCdcPo/Y2Qwfv1LlVT4ppd6MvZenyOCf5/T6R4ViEU92Se35+1HWPFzR7zOCtLP+Cu4Y9Svd7PGkuYpQ6DifYETZOrxSxgmWEpY5PnuAIQ3oE4BYxJKT3IxnIVL4QcoIPw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGjB3n8Wbeo9L/gFr9msILVTrCs5sYyjgLgri5xBtJ4=;
 b=cLjvpuwa2LAOo0YnIcf5BTYeE9FnVSMa/cOubx55tAqXAyOyfoH+GAYV7f0ZFJO0w1x4F8nRXrG9szzf98pvsA6JBj3IlIO0dWml74CSjb6zn/dL2Hdm9eby0oXdprZTlSv4fr9oliHTIoGMrIm+VYKgytCSYX2xLt5Z8MaHFaKS/FoaJeZcexfKvlOqBKbhbyYV+BNBzA6c85zhNb9DNk2fBWEDUiJuqHBohNdg+l/amOGSGieRF32kbTAfp3flNgsY5Z2fLqci69/cXbfPsaFnWxSyZB/VNIpFCKS1wja9CHG1FKOGXYoCexwcqp8dTiIAFAMFs+KPtziD2AhwNw==
Received: from AM5PR0101CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::18) by FRWPR10MB9394.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:d10:1a3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.25; Mon, 30 Mar
 2026 06:10:23 +0000
Received: from AMS0EPF00000192.eurprd05.prod.outlook.com
 (2603:10a6:206:16:cafe::27) by AM5PR0101CA0005.outlook.office365.com
 (2603:10a6:206:16::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 06:10:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF00000192.mail.protection.outlook.com (10.167.16.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 06:10:23 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 30 Mar
 2026 08:13:02 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 30 Mar
 2026 08:10:22 +0200
Message-ID: <6bae6852-145a-44da-86b5-5bbee6d8ac45@foss.st.com>
Date: Mon, 30 Mar 2026 08:10:22 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: stm32-ospi: Fix resource leak in remove() callback
To: Felix Gu <ustc.gu@gmail.com>, Mark Brown <broonie@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260329-ospi-v1-1-cc8cf1c82c4a@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260329-ospi-v1-1-cc8cf1c82c4a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000192:EE_|FRWPR10MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 8810a200-d2fa-433e-0a36-08de8e23075d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GfNuH0SOS106IPg0IG3imV+BUi6rEVgFbBp1++2FjF0asPKFD0qCVer1dPOWh8BKxGXmNzlqjx6gLfM2hgqhGY2iMQTNESi0ZUTeauNtFbaWOWi3jYXO6Yi1xFRgjHi1Fehb0hSjJmMDFxoj4RI+6lZ0iq11kybY6wAVdjOL5/DWZxa3Uppx7YIjeZmluAItYSvGDtas6jaumNU0b5bN9WrVD7/cJvGyYjxrSqonWn9hOs3vZVnfKV6CVNRDtz6QPvFKKjNwwVm/Dsl5AqG+uMJOCcnPsCqQhnWmLmlxII1XLZpzEFYexOZ9R86/Sk75CgexRrZUnqQuWPZW8hfoOEM4AvKZPDJt8AIfQNcw7BK1lOFVJVD1PCWpqT09OlF2wMxLsrbSQLEaOKtyjl9idSerIgXMMRSMLFsDS+EN4fn0jzWyQXVIbmnByJlcaCeF+o45nf7iYm+bSu4a2q+g7fGYtAsp36Prt7NxuYpOxYkuHF/k48ls5/YTcxhBf7w3O/5DaAc66AMZvVRUchCBHrWr6BDOIf1/QH0uB+7GWqCD9IK+0saCoPGctJS/3XhqNIXKzXUajdoL5NrA6DPcX3lohO/Q9qE2Xw6Adu48H/nXUkv49IF7nICh4YSWZBnQ3atvZ2OEENORj1ehAHU+khJKaEb5K80xLRnzYgCnpb0yWozjm0lqQZeUrF+dTLAEoAu2v5pinNZ8b4c4+p1ouU58oCnWxij13IudKsJ6USSkwqwe80t5YS7SDrEEEXjJ1ipuyYBVOCd0LA7u4Z12tg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6bd25dp9DCWmhPeP1jvcZBNv28un2GqvYLVSuZ3SENd3q4YMNdykw8MMu26FPi8SjeLtkiqI4Tqr8fhHUbPKOEWMilj1/2WEpR9RpUxIl1oPxZZvLEWFP+0RkLmrPkCBFx6Utcb6esSgwRrBMUSx6BzMom+bcL6Pu00cgYwe9GoMaCcLwr7SG2k43LeB+Nf11TPHEAI18Ci/2Uh25mTPyeknlINxi+HMPK63BE81pydZvn6kob96Tx1pc8okU6XJjMbBi73QiSSylysyX7NgAkNp3LT6emEsLWfFGEwz2NjrAUxmgJhwWG1ik0ca7vpxCjtr6o+ZzBEAIEW4FAzutJG30fpZaeLZevYhGdd+HFTnytuGcFNtgZhacXPaldNGyL9ulcBZshXSb7HOvjgkr2lGoQufgI3AqLgWJzqUg+pt4pYb/8vrqXIab2i0KYIG
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 06:10:23.0823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8810a200-d2fa-433e-0a36-08de8e23075d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9394



On 3/29/26 13:14, Felix Gu wrote:
> The remove() callback returned early if pm_runtime_resume_and_get()
> failed, skipping the cleanup of spi controller and other resources.
> 
> Remove the early return so cleanup completes regardless of PM resume
> result.
> 
> Fixes: 79b8a705e26c ("spi: stm32: Add OSPI driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/spi/spi-stm32-ospi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index acf2d182e8b1..192a20de1ae6 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -984,11 +984,8 @@ static int stm32_ospi_probe(struct platform_device *pdev)
>  static void stm32_ospi_remove(struct platform_device *pdev)
>  {
>  	struct stm32_ospi *ospi = platform_get_drvdata(pdev);
> -	int ret;
>  
> -	ret = pm_runtime_resume_and_get(ospi->dev);
> -	if (ret < 0)
> -		return;
> +	pm_runtime_resume_and_get(ospi->dev);
>  
>  	spi_unregister_controller(ospi->ctrl);
>  	/* Disable ospi */
> 
> ---
> base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
> change-id: 20260329-ospi-6aa5060f090e
> 
> Best regards,

Hi Felix

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

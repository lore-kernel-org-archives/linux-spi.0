Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EDA368944;
	Thu, 26 Feb 2026 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124414; cv=fail; b=li/0jA88zZQljgT/XN7IYoZ1LFmrAx5VAFGQJ5csa+sCDc1wjya95xEu4tCW5LDEKO4OfEkrpywBYwd+BbyKmLHVhQtbtsNpLLYhAYYjUTAZFPMxRkTgjzwe5DkWnmFAx99SOfHnghjMmMjOdp/2+iXMlISsgu4XrshHxVfEWk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124414; c=relaxed/simple;
	bh=q27OfDBOpB1MBFlqYdj/8N96Ygk4IOw5BUTTPjTtm8A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pICrH20Zqkx7xFTsOcGH1GAA9APu0ukt0qjFNm4zAhgMJQK4VZPr8MsKZzBGZNf9uC8WjVvM0Ljtjd2GPCcn/PFhvamMdpbXk3Sd9eQCJJcPCssipsRCmzydz9cZHiD9x7mWFGzKX6WPR3U2BlHtAygJWUXLNGk7S7eAmN5u064=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JQ0hWynN; arc=fail smtp.client-ip=52.101.70.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JQ0hWynN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJ2Ki30V0warTyPW49wi2ku4eiHqHPtx+mXNvgaLM+Hy2llTv4DsnWuUhayO/Ile4jwbbSpQLJMrEvDmNixdN6anPwEO6/u8FGLWjMk07mIzwGDeAQh+QrXyIrbLle1NJMHmpXVy7O5a7OKth4dT4Xotqv/xmXEcZAVLqyLoy4d72qynSLx7PH+N9yNqKwZ27ZNkImvxh140seYSDLHja4E48DCgXKMeVK/B+Ot84cr0fO11ESonb8m4XgFStEl04yAOqadjNi1CrqmEdW561t4yvDOLQDkTKrfgKXjFd6yhnCkg4RnqQZvFobswFXTq4MpiHOhFw4KrJBpbymGFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fk8NLlHkhD53dIXYV85RoJYZP852rCqMTPf3HuiPxuc=;
 b=Pa+oy7cqHkJt6bAGzqvuj99lYZSzViX3m4nUltpdaPZdvqVooSNeedH6kR8na3nu62D5uRM+C1i8yk1dkReJRSHC/HCsvyuHs6d/mgQN/XzmojECFT8BETCAmPsxgg0n0UihKv6WacLJEmIn9k3gaqVJLd8RaOdadBUTSwuNxZDcya1yKyVnROrJuMmXRsPkdhjBuBF7ejAL66xA5UFxghbBbq9ek8nzxia4p8dc8SjNbMC//PVX2eIZtZ8gmn4JZztGzDZP2lyOhwGVSDGf1c8cDBOW/fvS/ozWm1Jl+vVHDfVXT45MkEpwOB4r4aX/b1l+/EKgCHrjwJZ4tsqo4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mandelbit.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fk8NLlHkhD53dIXYV85RoJYZP852rCqMTPf3HuiPxuc=;
 b=JQ0hWynNvQ9OsW6Zvgfa0JkPB1jV8Gs7krx8e+4TEgxL6QlXIpWGUP2J0FCoGsLD0WHv7hco0sb0o5XhFWGZPmN7rDlVyRRFCfxJE2R6OGoQISD1/VJmz7RJMU98f3xGuF7cJfSGPdG8BJs9t5du7/zelp96fO8XyZPHFx+KdXHrK9RKhlcLcM3TAzddU/4fGx8uj8vD+Nq8lOdmw43gsngreM6/+YPkTf/VFvBvwpEVd1ydv5PMn/k6QQvxBPgjIBO1ip1vjPgXYI5El7DFBccp1k0x1VPc1mw+ZoHhBrpT1QbsFtht/qiy9af93N8S/EUl9aLFrIjIQ0YOs3gNgw==
Received: from DB3PR08CA0011.eurprd08.prod.outlook.com (2603:10a6:8::24) by
 PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.13; Thu, 26 Feb 2026 16:46:49 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:8:0:cafe::83) by DB3PR08CA0011.outlook.office365.com
 (2603:10a6:8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Thu,
 26 Feb 2026 16:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 26 Feb 2026 16:46:48 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 26 Feb
 2026 17:48:55 +0100
Received: from gnbcxd0016.gnb.st.com (10.130.77.119) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 26 Feb
 2026 17:46:47 +0100
Date: Thu, 26 Feb 2026 17:46:41 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
To: Antonio Quartulli <antonio@mandelbit.com>
CC: Mark Brown <broonie@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clement LE GOFFIC <clement.legoffic@foss.st.com>,
	<linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: stm32: fix missing pointer assignment in case of
 dma chaining
Message-ID: <aaB4z_A4aTqirDGb@gnbcxd0016.gnb.st.com>
References: <20260224-spi-stm32-chaining-fix-v1-1-5da7a4851b66@foss.st.com>
 <d14f3943-b97a-4940-95dd-39c6fc240130@mandelbit.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d14f3943-b97a-4940-95dd-39c6fc240130@mandelbit.com>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|PR3PR10MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 910a6b22-b5ff-42e9-f7ce-08de7556a2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	CYXCXb2Mm6NysiS8vrtpDAY1pgSFUvcmwMeKYPepIDybfxQlUW7+2mYu4ivmAGxStztPPT4Ci/NDTJyDpGydbITopBX58RoCemJ5ASeYtBAcfAeBYcyrUOZrhbgnPMndB1xPl5Jfj1Nw15aeA9TujzijODzYhOHy3k99UTkli1+D942cjD4HRtDdppJi+kofw0Bl7tZOTt6gAQlKwepxR65Zb/BMFoD1r2SKMMSTfsNfaCr9SDQw7rn1FdagZ9YwUyPPc2tgqNpVoOzy3xfotrqOZ6gvUGyPEeiWlrmuNQfNguOql7ZGtBhhyxbHDiTvpP1SEcXM2LiDzvpKnHINlIFChIg6kXBkK/wx/gOgkm7jG/onrMe5BWYY8nCYEjH99MrQJ3iADXK4qz5mm1vqh9wIQfKn8apRpSXLLrBunkljr9TNWLWj16Z8gNiG8ujZNMl00+ZbJONtShKLYCfRy0E3WcFNrZYg5BWY+VcaVCUoOTSrk5uQEIDOX9hIBzuDKU08tLBEQOB9xuzxSWfu+oJgjePB+Z8Jbxl2bb3Z0lSn+E4agnbO27FIxpVjeS5FIqMDlsQzwaDXnr29u6QqJasUW5PFC8csJA9PefAggfV9PEdF+MzOfHSESkP3nwGzLwy2baW774fby042jbNva/RJdhWpNC7Sgk+icKCU98IXPJyoiPDQjapf8kEXx2hXggj3fCVtcut2ZVjTY6L0PcjTv9lJeW7yiQ+mEpwKhpRpa5+dq2YTHnuDC2a6W0Ekvk8CLSFyHLu4R/ZnJNCqLd1flZmHpZhybVALxsCq973B7b8R1hTYnb3TxAI6osC4otFrYTplYYNysrhEdu5tqQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VXTXnRzEh5YfonnSP3HePI9YrWco8hiFotl9GUuUHPnl718nqhWq4ujjyHaX+foXO4ElTymdn4uvwDMg7OwSURK6pix0kl0G1xfn0ZmEmnjvJSnzmEKmQ5ym2Zu/Jw9hgap7kO+DGX6MxJFd9OWdONID8fEjRXJsQRZCiSIRZmoQPdV7jg14UTMjgFjBMu73lVGAwCJZU1L6+04HB6IzpmOirGqrEdzxBcmBlHsCvWoeewqt4RZX4l+g+f89UdjMv1KPhZENFSydlOd+jz4CNLdpt36ayyQw+AqU1cLyjys86Ph3nh5nZ4c8xj1PlBtHglskIgtQIygUJQkdYitVG0st8sM5bWW+5RsyBMp+qD7OmpmJ/diA4eW9o7OHS3oZjgYQGtar5KP747H5WLA8wQnYFi4T4EYL7EQXlqqEJkjSsQqKPracKBWCJdcjMJ3/
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:46:48.8251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 910a6b22-b5ff-42e9-f7ce-08de7556a2a1
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4046

Hi,

On Tue, Feb 24, 2026 at 04:25:14PM +0100, Antonio Quartulli wrote:
> Hi,
> 
> On 24/02/2026 16:09, Alain Volmat wrote:
> > Commit c4f2c05ab029 ("spi: stm32: fix pointer-to-pointer variables usage")
> > introduced a regression since dma descriptors generated as part of the
> > stm32_spi_prepare_rx_dma_mdma_chaining function are not well propagated
> > to the caller function, leading to mdma-dma chaining being no more
> > functional.
> > 
> > Fixes: c4f2c05ab029 ("spi: stm32: fix pointer-to-pointer variables usage")
> > Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> > ---
> >   drivers/spi/spi-stm32.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> > index b99de8c4cc99..33f211e159ef 100644
> > --- a/drivers/spi/spi-stm32.c
> > +++ b/drivers/spi/spi-stm32.c
> > @@ -1625,6 +1625,9 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
> >   		return -EINVAL;
> >   	}
> > +	*rx_mdma_desc = _mdma_desc;
> > +	*rx_dma_desc = _dma_desc;
> > +
> 
> Thanks for catching this!
> 
> Indeed my fix lost the pointer-to-pointer logic, which was needed to pass
> back the computed values.
> 
> This patch looks good, but at this point I think you can also remove the
> lines:
> 
> 	_dma_desc = NULL;
> 
> in the error paths above? Setting them to NULL makes no sense as they are
> not going anywhere.

I agree that those lines can be removed. However my feeling is that this
is not part of this fix since this is more about removing useless lines.
If this is ok for you I will propose another patch on top of the current
one for that purpose and without the Fixes on it.

Regards,
Alain

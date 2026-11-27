Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795768901;
	b=shqrjtDygUpB7RFQfXk4YKsp8DldXYxeedAl/Hwa/d2oxngqipcceWozkDmVXjr0qZE9
	 I2hts6lEbsI24d3FFDI7QlPs3pEHPHHr9SOGpmxoAWYk9SLsm0UV5Jfq4hlxFOHDIu5H7
	 yW81AfcW9v7NOn2p4+tuvaRVu29/xCNJvyLc0ttj+GNgBVIK3uTeHGTJM4vZ+5cH04r3f
	 CYv1usgv2OqtZxgpFXl4IGppT5JFiJGeaq1qw/jekdbIZxYhUvD5jXp9H1FC1ND4iORgX
	 sdfbyBAga1czIzIxmGCu27r2abUVHJerjhB140a8g3AOfr3KZLbEPPKbMmbCAECj4qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768901;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=dJ+TZ7WxCqhJkKI+921LIlb99IFin81b71zLNJHwe6c=;
	b=D/be0uboB5nAv8Ox1fzq/McGbNKwKRj6jPH/PDfWUe4Ol44cCqKo/40nNNoLCvsNfmzp
	 aBc+NrzQOajWu9lNqWWBuxfvOjubErXm1IBjGZP/8q3WPOFl512VNwDLrfJ8/9dkFt3u2
	 ylEuOOiy8kK0LYr0j75vDgAPbOmKpcYlqpaophwDqSD7IITnnSpU1eDCc11PZ1pSet1+o
	 GrJZGP0JghUrzbqIfpbPx1ZRtIpzXX5UNbjBdMS1yLYvWK84EWoHfFFgJI0soNjCwbFRy
	 FduBjdiUSQ3B0KGNc41YZO+oqX6FG6LjHXltA1cMcS+FtoqMCMmLRohVU9rxiL2jpbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=d4+WGzwq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.13
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146AA606A31C;
	Fri, 27 Nov 2026 08:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 146AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=d4+WGzwq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hl94MjyPwwMLbdMXXzd2j6vOfUzjF0RlqDFSgvQxS9gbN1Ze86G5O0q12xXcSCUvBmjQl8Bj8HDWt+w9pmKmy9XZg/8vdbIcxLJS594ZfEldczJlHZxkkQ21/b5Mh7n1xAwCo4E5S21YW3KOyDiT1SDA7tEFjWfn2A6H3yo6uDRuGwMpQDUoFyx7c/h8T89kt6ztC9XOdmljunzlJt3jmeKBdTKJNis+PoMiI6TSkZw+i6YLSDeZn364o2QDtIW6w2N7MCg0LWltJosMlyf64ZCBGIz2evEwL337fYhG41caGj+0XXNhR9yt7dQ3xbY+jZ2b6m1Q5O7Kie9xd+uWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJ+TZ7WxCqhJkKI+921LIlb99IFin81b71zLNJHwe6c=;
 b=P1bDbtmbTEf+UAr82X/dgluxpVMXGvQnzWP6WwO+6gNPn+IOnXa2li1qaYbzFd1s2RsmnvVWCIl+asNEO1N0PisaOscG9A/RnFaDb1NF0j+YHNGK2BlXBKIgwLjIc8Kh81isVs1vv4xYShgSqoMYszhvHGIA2nvZlkA4JKu3wiZ0VdF8THqbQdLAfzrK73cwGkx93IGUnV64jANmuHjdl6rvgEts7A/D9CcljoO2IP+T7zVv8syZNIU9tiubzxTGO824MY5PcMWf9isviyYhzzZExxx0nfFbKSNiw08kklYlfeES900gyatsSmocEIjyo1ynXkJH7RfcAF0eVn65VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ+TZ7WxCqhJkKI+921LIlb99IFin81b71zLNJHwe6c=;
 b=d4+WGzwqKOJZvRcbPU1VETQRBVlNjRcJmyUoUDAPSqdd0Y2wShOobBkR24QisvpmBpCJmPnlldme+YCfEG1KA/BDnmh3qhbgapwSvuBEaUES4cp5uteYa/30TL61J5Rp2RPzJgnETpyhsja5XjFdOyOu7Ebjt9H/l/xPKDF/C7MpQLIUQGIU93Dxq/ydiPCebFk6XbLxXvrrIFi0Nw+RVDaUQw+wlPVb/dQ+2o3WN7CF7i4l7G47IBByaXoVm6RYa8XDH1o1LhHTjuZBbiWDzT/I/WE6+7DKwv04+9s51L/BnBp6DZqFsd5U8b8l6y55TBpMptanhhJZl/kM0Q6MDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by AMBPR04MB218877.eurprd04.prod.outlook.com
 (2603:10a6:20b:78b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 08:41:38 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 08:41:38 +0000
Date: Fri, 27 Nov 2026 16:46:43 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Liang Yang <liang.yang@amlogic.com>,
	Feng Chen <feng.chen@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>, Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Haibo Chen <haibo.chen@nxp.com>, Jyan Chou <jyanchou@realtek.com>,
	Yu-Chun Lin <eleanor.lin@realtek.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC 01/16] spi: spi-mem: Handle a corner case while
 sanitizing ops
Message-ID: <20261127084643.ekeao335mv5n5kow@shlinux89>
References: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
 <20261125-macronix-upstreaming-spi-mem-cycles-v1-1-fd036402fd37@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-macronix-upstreaming-spi-mem-cycles-v1-1-fd036402fd37@bootlin.com>
X-ClientProxiedBy: SI6PR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:4:285::16) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|AMBPR04MB218877:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a552b8-ffaf-407e-3e08-08df4c624023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|19092799006|5023799004|10067099003|11063799006|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261026121527099003|261026140227099003|56012099006|261022075727099003|261009223027099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lHV1rL7PT6bydAwT/8DG/qiDBu3CTcJm/nfh5r92vxFhuReM9a6QHlG079gLlBB3O7jYyJR9NdVpENn/5EImU7nXe05leL78cn9s5ezQF7TIpMRT/f81ra5ZuRk8YWk1hKr5qc7ggbskTPbi3Jd4ZjlvQzLa5hTV+wbomW82EWSufyIFO1S0alal+3eskDU2dGzj73gpRToLuiILF2J0lHrR1TX9bpofJJYF94PHERNKv+5darrpUnzespUDN5lRNWKErJtryEAe39LQGbZWj2/NFWJK/a2Lj8LeCOXIVOgYtkbcOMvbT4iXFHsy8kXCyNb3T0YRCeAGiIdyKVl5o6RrmY+O+I+zw+Y8XgvgHhL2TJmk+qdolC/eKF0+Darwx4nx6QfdlU78tzACCpBG7fh+gJYGOSgN8KPXR0GOQG+WzDgGt6YWPOzMX68kox87xh+uqJq1anq2GJzORMFofQyLajzvSWKqLYkThsVt4AIrGaNMt/vDZeZingZhVj3t50ywm5te39rzfaMzMBxwBBa8JbGodCJE8vXrvgMPuMCme9GgixkN6A2XxSkshkzLeMwES9YiFWnZLyAWSZW0+IpiqhMXeKyRUD51ArfM1ZmfGOsJ/eMJbZdRyUGr+Z0uOKNY4CSCfPGxEamy0u9p+PywsO76NJRcDY6PF18G4wM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(19092799006)(5023799004)(10067099003)(11063799006)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(261026140227099003)(56012099006)(261022075727099003)(261009223027099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HV3pPnCMJ15fFURQj3c0FyH8Rn3MG0+bV4IXMs5K362Lz511JkiNdlQ16rqe?=
 =?us-ascii?Q?O02whxuZ/0WpSCks/K9YENq3Y0R/TAU1dCmviFnK7cwtV2Cw+BXw569d8lSj?=
 =?us-ascii?Q?q9Z0t957WmGUuPyPDWpGAy5XcPp0JBfPq80i1Fv5Odr2uIZHLun+eEcHJTe5?=
 =?us-ascii?Q?vfO16nhwAwP6b2QnepbYrHOdo0t9GMxU3lQQQvrfP2SFdQzn0BMM2NlY+dCp?=
 =?us-ascii?Q?E8h52qLZfDif6W0qZPDYtZWzlQmU9JP2XfMGE6auig8LmtYWRAVfIDA3Bs8g?=
 =?us-ascii?Q?4ufGGaBzE/k4/DZ2Zwo5G8hK/yMLqjOkffJewGQ+k8MWVO5BmA4ZXeTF84IQ?=
 =?us-ascii?Q?aavNfxm2vLA/Q8/FS4gXu8cXbUlI0Bdh6GwwY58U3vj9XfT1M56gs2qZ4bcy?=
 =?us-ascii?Q?K+oz17keoq85Lt2CWCeXrFh0/0htSCOrmZt0fe08fMPkTNRnEcTnCUssY5Ev?=
 =?us-ascii?Q?0+QoT04Eeqj1XXHJargvt1Fwu+rP9cfE5dtk7oyMRH0vWfu6s+UZHIwwD85R?=
 =?us-ascii?Q?XBI0ry9HX85u7JNZ7OypkYGKfVwGZHRj12eu2Kd4MG1Gm7eTMgCpmfkH6a7t?=
 =?us-ascii?Q?SkSJ8/dIDr/FBRhffU2ZTB+jNFfpl1pzaBJc+K7rXPkHtCCkuOe1i/dG06Iu?=
 =?us-ascii?Q?QFx0iUk9J4bWDjA4voqIAdm9cArTHuMpc98og2DPMD/pUEi8y4QSbcyWpNBO?=
 =?us-ascii?Q?+nfF7BD+jsJAGqMJvyS/sbnoCFgubHLIV3bb6/t0BDih8O7g8EF5K1DlGLD0?=
 =?us-ascii?Q?oKyLIFCcW2yo4xvMrqTMVh3ywKpZcwfw3lEPqbk0o/w23+LJJZNt2JP8rX15?=
 =?us-ascii?Q?pd+0Ikd1dElNgnESS3/fQKB8Fv9zE2nTQpWx8D/5q0ggD+4aUbriQUmi/rf0?=
 =?us-ascii?Q?7F1ZYN1n2sJmPgbZmpKXR0IwkWqrYr9DExmUcqMTBKUYzUjTXeqML91OL0pC?=
 =?us-ascii?Q?EfZ9jZw3TsnCkHhGkfV4OiRMTOkpMgTXFBpaQKKdvToq3PKEH3Cq6O52bVUO?=
 =?us-ascii?Q?jjLeJtK8Wh9262IJQQWadqKaa9ehP09JxCbyVwTpxXp7oreaJ/ZEq+gvTByT?=
 =?us-ascii?Q?XTsJMauAfKxv94rH+qOT12/IL+mYvFNXMgMBFd2lV8rP7RhnzQ8G44v+8Ovx?=
 =?us-ascii?Q?P8/AWMXekSELPo4bcM4FdOTUTV+7oRclNaomsP2ay3x2ywU6+xwGoQl09Lzs?=
 =?us-ascii?Q?R73oDszJMvMP8G2n1qqvIZFSlZxSi50p6udfyM53EUlixURrSqi7wBUj2/tL?=
 =?us-ascii?Q?K86B2Y4pvAwWeLLXErLW1DDReYxaM7E0GtIGs2k9eOSANUA7mcUNyY8c3HaN?=
 =?us-ascii?Q?12PTVJyxJLuszrjJH8nGbgBxXFBcPqH8KpbpaKcz+ugR8zxUd8WKwYdeyxwm?=
 =?us-ascii?Q?FpTC83VLq56gNxtTUs/mW3f2d3HgoKhvnpqN+HtTVnM1ExoLQZu2EBUJKy/y?=
 =?us-ascii?Q?DKujuVem3ALp2NFajadsr6fB6KZSQ/ugzzSh/DMubqLgs1xpY1oISF09k4x2?=
 =?us-ascii?Q?qDkyXyNgpfIrdpySU/k/JTcxrMEU2ZFTCtPoq7tYpmwHc5CwZvuKxEYshglP?=
 =?us-ascii?Q?8bm/QBlwiQWmx6NlIBznH2g1+qXRzToeCWlGUv2CAI9atkfWrGI3FGa/XVLN?=
 =?us-ascii?Q?op/+VGErZZXdQhyaogl7CYlFTKP2NMW3rmxaXlcp6S+aM1mhGYN8I9TJI9iQ?=
 =?us-ascii?Q?FctyQnZv3PDBm6DuTPCIYWYb6KfAf83SUe9i1nGZ+728GjifHy1T3QosvcuO?=
 =?us-ascii?Q?fdMeRCw9ZCqfdUUis1umXBVuG+/VDD7i434U0x4fBw0urMuKfReP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a552b8-ffaf-407e-3e08-08df4c624023
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:41:38.0244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmY8W+qs3YxsTK4NpF+9ULRfHYX7IZhB6SxEggr3tzaxCC7+eEOWvYNcOgkv2CoxjBc28nTDhTfSzIMJuSm16Wz2q+XhIwdkW9gRTwKx/D+MiAU/DvaYDxFwwrN5hUjb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB218877

On Wed, Nov 25, 2026 at 06:51:15PM +0100, Miquel Raynal wrote:
> Some mixed mode operations (such as 1S-xD-yD) will be flagged with
> op_is_dtr but will not enter the ODTR checks. As a result, the number of
> command bytes will never be checked.
> 
> Reorganize a little bit this helper:
> - If the operation contains a DTR phase, sanitize it.
> - Then sanitize the op, should it be:
>   - ODTR (8D-8D-8D)
>   - anything else
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-mem.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 8047b7508c8d..c64e906ba919 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -170,6 +170,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
>  	struct spi_controller *ctlr = mem->spi->controller;
>  	bool op_is_dtr =
>  		op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr;
> +	bool op_is_odtr = op->cmd.dtr && op->cmd.buswidth == 8;
>  
>  	if (op_is_dtr) {
>  		if (!spi_mem_controller_is_capable(ctlr, dtr) && !ctlr->dtr_caps)
> @@ -177,23 +178,22 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
>  
>  		if (op->data.swap16 && !spi_mem_controller_is_capable(ctlr, swap16))
>  			return false;
> +	}
>  
> -		/* Extra 8D-8D-8D limitations */
> -		if (op->cmd.dtr && op->cmd.buswidth == 8) {
> -			if (op->cmd.nbytes != 2)
> -				return false;
> -
> -			if ((op->addr.nbytes % 2) ||
> -			    (op->dummy.nbytes % 2) ||
> -			    (op->data.nbytes % 2)) {
> -				dev_err(&ctlr->dev,
> -					"Even byte numbers not allowed in octal DTR operations\n");
> -				return false;
> -			}
> -		}
> -	} else {
> +	if (!op_is_odtr) {
>  		if (op->cmd.nbytes != 1)
>  			return false;

Hi Miquel,

So this change means no nbytes limitation for mixed mode oparations, such as 1S-1D-8D. Is it correct?
I go through spi-nor and spi-nand driver, seems for spi-nor, for DTR mode, it only support 8D-8D-8D mode,
but for spi-nand, I notice some winbond W35N chips did support not only 8D-8D-8D mode, but also some mixed
mode, including 1S-1D-8D. Does this 1S-1D-8D mode really has no such limitation for address and data length?
Address and data are indeed in DTR mode.

Regards
Haibo Chen

> +	} else {
> +		if (op->cmd.nbytes != 2)
> +			return false;
> +
> +		if ((op->addr.nbytes % 2) ||
> +		    (op->dummy.nbytes % 2) ||
> +		    (op->data.nbytes % 2)) {
> +			dev_err(&ctlr->dev,
> +				"Even byte numbers not allowed in octal DTR operations\n");
> +			return false;
> +		}
>  	}
>  
>  	if (op->data.ecc) {
> 
> -- 
> 2.56.0
> 

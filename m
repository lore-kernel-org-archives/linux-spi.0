Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3535234994;
	Thu, 16 Jul 2026 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784181796; cv=fail; b=hvK9LF1yFKL5wHy9F33LD6EJQKTwnh/C5LZtPelxbixG2MtLOpUisVrWknsuU/mpPSAWIzUZlkVCdzHw0g2O82qMIAdCHS+H/54shh58Gd22v/KMHYmSipFXY3eoenENjU+z4Azi0ZWAfDrT3JTqIwGZEGs78gVDkcZM5mNdWXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784181796; c=relaxed/simple;
	bh=uUmd2fVVzInSxG/PMOra6XNm0iDVrJeOcM/g0ZEynCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q8hHAIqCxrwFBYLkZSjA9NP/NAKrRqdcR5eFdKnVnXhh2pvpnec8yvtWW50al/pKaTARg4EQYIvK0GR+v7yQNshbUXmB2bgTk02sIBsBSBIdKscHlM9Xo0TfmbdMWgGLts3V/vSjjn6f8BVjf9+K4nYvkOwcxp+VFGZqhiTh9Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Xqr0I0o/; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MQO7GSPE; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Xqr0I0o/";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MQO7GSPE"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G3uWc92768839;
	Thu, 16 Jul 2026 01:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=sIRTwnEoS6y5uqz3DnKe+DWP1ocNdnblNy3FSBMlD
	nk=; b=Xqr0I0o/rmzPCGDsA+o13ia/xQp/nMV9sqL8M1dkaE495l7euB30SbcBe
	G5RNtDhKq5CtrITQ8GxBBVb8Dxddda3a7kPej3dMREZbsNxDKvD+MO66bwTVCeTP
	EOVD8o6VfslTeee5v/ekJrcC1rfj3NagM6CTukJK9J69W4eChAckODn9iz6Pg8Jg
	N+F89zi0eJdDBc9DxbpzH//p31mNsTtllAOTwU15spm1vDDHLb8u7dT0Sy5A/tku
	qLkpCiEXM+Gbu86Miog5DOXihCeFu3QQHCge3vQdU22KOmOt7E6hb8eivXwouxln
	DDw6+KcTCsqD8QqF/xgWzPlbvkh9w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fe9jb5t1p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 01:03:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lagM/8q4cNCM7/nJrz//mq1XVZA6QsllLbq2fHDPB28jLH9LRdYryn38Z4A0sB5iQhUV2L/E7LaET3ERE4e/vv8Z4w90eqqgZXq7voKgIflnXn6ubAA7CCPNkSo4x5eYBqiSLAoB1VhIrSN1ABDBSkdEUwFe3UdK/XtjgAMh8GEYN6CRuecGDyipWXAtDzprrLtJbCoI+IdymiuvVdmQ3TZ4gpBybyr4k7hPbtvn2Kldt3Q450Z7Xu/Q1VS29Fzs+3Ioadd69dVa8fBaZYuiq9s6O34wVRYS5Hi7NUUM3OlrYkX9j1egJtfbNgJ+jV8R2A07fZv6RFCAI4z6oNAvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIRTwnEoS6y5uqz3DnKe+DWP1ocNdnblNy3FSBMlDnk=;
 b=BpgV5jRFIsFhgOvWcsGTWPG7MwAqBqWsm/3tS3o7ZBZxfy3xcmoeMIspPMaxaM9tumfdNd1fi2fQ5QP2entQfuVXfr/OIzhO7r6upJpUoP5VquiXEZwdtIpSzasfI7rfnPsQXAKges7nzikLTy8tjRCG1mQ2dFwjSWBYjWipPFelV6Tjfw21tAa2SaEsNu537CR/kLcHrQPM9Gte6X0x3+brFXnanAkFHAqkoDM4Jd+XQE33gIN4+LvdbeEU8fUUZu3vtucsPjYitH1davdvUIYN4/CUR0TZELsF+zRCH7MnHKdD7FB/GpWmmQng41C+3Tf3h31ogE9aX+YjBBscVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIRTwnEoS6y5uqz3DnKe+DWP1ocNdnblNy3FSBMlDnk=;
 b=MQO7GSPEpd+dE8UkcKtGtumTYS8rPp3eiI1bKsyfsOGU4o8wQo/MoJvXKP3bqSZ2Wvz2T8VahDij193cdoZn1eec25wRjc8Dd/46yk8+Qa/AIefe2yaRvfuroXJxodSeb50fXPwja97EMJ1tHHhDZV1WGfwwcPrFHbKwhaJEDK0=
Received: from BLAPR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:36e::10)
 by DM3PPF35F036B4F.namprd10.prod.outlook.com (2603:10b6:f:fc00::c1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 06:02:57 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::59) by BLAPR05CA0003.outlook.office365.com
 (2603:10b6:208:36e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Thu, 16
 Jul 2026 06:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 06:02:55 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 01:02:23 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 01:02:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 01:02:23 -0500
Received: from [10.24.52.55] (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66G62HLi647029;
	Thu, 16 Jul 2026 01:02:18 -0500
Message-ID: <1ab838c8-ffd8-488f-b22b-6548723829ef@ti.com>
Date: Thu, 16 Jul 2026 11:32:17 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/16] mtd: spinand: negotiate optimal PHY operating
 point before dirmap creation
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260618073725.84733-1-s-k6@ti.com>
 <20260618073725.84733-15-s-k6@ti.com> <87pl15pgz3.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87pl15pgz3.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DM3PPF35F036B4F:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f18af5c-40ee-4b52-4cb6-08dee2ffe170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|6133799003|10067099003|18002099003|4143699003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BC4TeB8u2Tz0Z64+ZDKCnpBUNz1fPdSD3Tchq15u+tY7f4fgdQnbAhOuDZNDA9HJJOrJO/DKvgkG27G9Pmc3zZXSoRD5/oGSnXOLHKMUwMUS6CZ8ezyYwcXzD37U5cSKgYULgTNcmLpL5k7+VEJf8gt9Hsno16WqhI5gm+xolv4imbVoMveTaIKv/J84O+vKFTFPglPjydfcknUJoFcGDVeXDcC4hHlZZRHpIzANN7bwT9eSepFxamtUDT90JnvClZ4AN7BPQQhS7GjvDnK5MW0iaPwjFoo2YmoDaIgFq6aqGunCUQFKCXUO1iu0+w9LQNM6CHarDpmcBgo9Pcz7OJbF6Dl9Iv7vheQUX+RSc7D1oIXYSzW1AsYwYgp5qw8jUHr9ynNYtnB5M1uKtOAfdUUl1apcPNlT+m3FuAEkACgPwsJAj1nvqegGVOJzegVGEf0Gxt7nQJ9ofA0yEHKZX03x44ixG2hJggmHfy0dOj3JsHG7dG00FCsNy0UCBr6utkApYgkGQhcjuwBn0DwRDt7SlW9OVEeXaDAc/urIjfcgAEcg9Whcd3lrMX3wtxfStkLNnOyLDvepiPBvoazzmU6JDWYnG/Z3jXKv8mi52IKmtDVXNpKVLBhVnjred+mfKP98EHm9wmjZGP0ZyBpq8U2R0In4SPXuG5PM06hqEkUff/nhpzuVi5N+8OrVxBlOPlgXfeG4oBcYGwK4xNEU7w==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(18002099003)(4143699003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h9viAX10sPjVR4jT8uCdzZWxOGGK7eN7h8OUR4NgzX1QemZd0/beX+JQnks/nO4m9JdbT+Pdo2UK6rzA5FEtryH6iqcvwi3wuNAw1CHq/FoM4XdlseYSJ1zAXtbbykhfvxr0EByKMbfNDUrcRUG/b2F8vYRhS34SBqJYx5egV8NJhnPosxnNZh62muBfo57UumPpER1HWgmllwv79ePJK7ONK5HlmAthEY9fQkloKWjBMwuBdIHd0mvqSoh7AChmtHw3S3OPStL3nccSi004llss6hupdKAiOG+tFXmlIfoiARKyQAlse32gd77yd+JMUF6bsUj7rLvyqPU1UGp9OUxEJ/nuYIukW4kozgZOyk9nKrbZ4aSv/fj/rue6DhNlTkBd/bOw1AQDYhH6px4xdAiU16c3P0pHGIRpAme6JFK+mMYVDKf49BjnMphG63xt
X-Exchange-RoutingPolicyChecked:
	ZekoYPIBOCrVOsf3LSOkUTW4kyDrm682UeMPx2lw87ZviUlDhuCIxEmyuIeqnfemuwFpWS5IVP9BgyqHIulDC7+qRDMCzUWOdZrx5CDzOt7QLpevoPVBZpYYE0EV46Pg+A0aIpy7vxm1Zirzy44quReD4zi6SY0sTX//HPxEqZQkk1t2pvI74AXLEyK1425UJq2HESc/tXQCLipOwkNFOw6q3xsGrIlkh5vPsQcpONQUGL+m1qwXJ8zHyZpPVVbZLoHj5w+mUWgPbvygZ21uCMSnQnvA/7152tzG7t+tpM+IaBoKGJAXmjKxHGK95XRw4lkl1qTI/7XPF/APDEQ7hA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:02:55.8809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f18af5c-40ee-4b52-4cb6-08dee2ffe170
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF35F036B4F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA2MCBTYWx0ZWRfX1nmZmeVarC63
 2iLswiqtkqMgwaqp9MdC6hxeZKxg/lXK1PjqdfbkbzNY8TakTB7kuP6fKwOCTS1VIocJHDXC2cR
 9axWWsXHnHYii/E3XYNlNa6Umzi1WXxpkRcm3HMucxWgSyRZEw6Nwmr5A2DG9zkA/J0loCLqwek
 kP02HLed75vd5qUb5PcfPqnK2Gr+tr+ArUwo4nra1mGR9/P8GuiGmFq4u7j6h6LWBvxELLJt+/I
 Qhwiwps209vX7KirPboZNs/GHj7l5AxcZf8kmJNMPUfZUTsnYXZs3e3XGNg4eg4Cuk8pBWNgKl5
 7OGtNqUT83OCSCptU0LJsZ0p7BRiAlRtI5gAJOoeA36jR/0K3XcVB4huK6IWfDnCxx9jrSWViTb
 En0t1VXjGDf17+FcHopN8DkS/oqRMfoRreSgJetAoL4qZiUX4b1f0uGhS286bN38Kt8Fd66eQuE
 H8/5O/9r1OPUZE8W9dQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA2MCBTYWx0ZWRfX8P7iXMX40dTd
 4zgG/MlEOtkyd2bPu/N4iiANb9XPtnCxHOCB/aotanIB57yCP2Pdq9pliYXwSVFOzbSMTCdOdUF
 UKgmb32m3lB0mo1zqQ9pfX5LtK4H2GQ=
X-Proofpoint-GUID: MHCYCZ3-5Ba8FZAJJdLi3u530zZN5l9_
X-Authority-Analysis: v=2.4 cv=ROqD2Yi+ c=1 sm=1 tr=0 ts=6a587416 cx=c_pps
 a=j0vpRZT92jK8pnwqK8unXQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=AE2Ycx0SAyiybhrihtUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MHCYCZ3-5Ba8FZAJJdLi3u530zZN5l9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160060

Hello Miquel,

Apologies for the delayed response.

On 02/07/26 20:38, Miquel Raynal wrote:
> On 18/06/2026 at 13:07:23 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> Dirmap descriptors encode the op template including the operating
>> frequency at creation time, so PHY tuning must complete before dirmaps
>> are created to ensure the validated frequency is embedded in the
>> descriptors from the start.
> 
> Good idea.
> 
>> Move dirmap creation from spinand_init() to spinand_probe(), after a
>> new spinand_configure_phy()
> 
> Fine with the idea, but in the core I would like to avoid TI specific
> naming. We can call this helper spinand_optimize_controller(); for
> instance.
> 
> Please, do not use "PHY" in the SPI NAND core, because I find it too TI
> specific and we need generic enough naming so that we can include other
> controller's optimizations in this logic, if ever needed.

Got it!

> 
>> call that negotiates the best available PHY
>> operating point. spinand_configure_phy() tries the pre-selected variant
>> first. If the controller signals that PHY tuning is not applicable for
>> that op, spinand_try_phy_ranked() iterates remaining variants in
>> performance order — DTR variants first, then SDR variants after
>> switching the bus interface if needed. On full failure the device falls
>> back to the best available non-PHY mode.
> 
> Makes sense.
> 
>> Add spinand_reset_max_ops() to copy op templates with max_freq zeroed
> 
> spinand_reset_max_freq_ops()?

...

> 
>> before each execute_tuning call, enforcing the invariant that a non-zero
>> max_freq only results from a successful tuning.
>>
>> PHY failure is non-fatal; the device operates at the conservative base
>> rate.
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
>>   drivers/mtd/nand/spi/core.c | 214 ++++++++++++++++++++++++++++++++++--
>>   include/linux/mtd/spinand.h |  11 ++
>>   2 files changed, 216 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index b678d0534297..5dcfaabaf2cc 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -1280,10 +1280,16 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
>>   	/* The plane number is passed in MSB just above the column address */
>>   	info.offset = plane << fls(nand->memorg.pagesize);
>>   
>> +	/*
>> +	 * Propagate the validated PHY frequency into the dirmap op templates
>> +	 * at construction time.
>> +	 */
>> +
>>   	/* Write descriptor */
>>   	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
>>   	info.primary_op_tmpl = *spinand->op_templates->update_cache;
>>   	info.primary_op_tmpl.data.ecc = enable_ecc;
>> +	info.primary_op_tmpl.max_freq = spinand->max_write_op.max_freq;
>>   	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
>>   					  spinand->spimem, &info);
>>   	if (IS_ERR(desc))
>> @@ -1294,9 +1300,11 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
>>   	/* Read descriptor */
>>   	info.primary_op_tmpl = *spinand->op_templates->read_cache;
>>   	info.primary_op_tmpl.data.ecc = enable_ecc;
>> +	info.primary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
>>   	if (secondary_op) {
>>   		info.secondary_op_tmpl = *spinand->op_templates->cont_read_cache;
>>   		info.secondary_op_tmpl.data.ecc = enable_ecc;
>> +		info.secondary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
>>   	}
>>   	desc = spinand_create_rdesc(spinand, &info);
>>   	if (IS_ERR(desc))
>> @@ -1744,6 +1752,17 @@ int spinand_match_and_init(struct spinand_device *spinand,
>>   				spinand->cont_read_possible = false;
>>   		}
>>   
>> +		/*
>> +		 * Save the full read variant list (ODTR and SSDR ops) for PHY
>> +		 * tuning iteration. Only saved when all ODTR templates are
>> +		 * valid so spinand_configure_phy() knows ranked fallback is
>> +		 * available.
>> +		 */
>> +		if (spinand->odtr_op_templates.read_cache &&
>> +		    spinand->odtr_op_templates.write_cache &&
>> +		    spinand->odtr_op_templates.update_cache)
>> +			spinand->phy_read_variants = info->op_variants.read_cache;
>> +
>>   		return 0;
>>   	}
>>   
>> @@ -1922,7 +1941,6 @@ static int spinand_mtd_suspend(struct mtd_info *mtd)
>>   
>>   static int spinand_init(struct spinand_device *spinand)
>>   {
>> -	struct device *dev = &spinand->spimem->spi->dev;
>>   	struct mtd_info *mtd = spinand_to_mtd(spinand);
>>   	struct nand_device *nand = mtd_to_nanddev(mtd);
>>   	int ret;
>> @@ -2014,14 +2032,6 @@ static int spinand_init(struct spinand_device *spinand)
>>   	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
>>   	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
>>   
>> -	ret = spinand_create_dirmaps(spinand);
>> -	if (ret) {
>> -		dev_err(dev,
>> -			"Failed to create direct mappings for read/write operations (err = %d)\n",
>> -			ret);
>> -		goto err_cleanup_ecc_engine;
>> -	}
>> -
>>   	return 0;
>>   
>>   err_cleanup_ecc_engine:
>> @@ -2050,6 +2060,178 @@ static void spinand_cleanup(struct spinand_device *spinand)
>>   	kfree(spinand->scratchbuf);
>>   }
>>   
>> +/*
>> + * spinand_try_phy_ranked() - Try PHY tuning on variants in performance order.
>> + * @spinand:    SPI NAND device
>> + * @mem:        SPI memory device
>> + * @odtr:       true to iterate ODTR variants, false for SSDR variants
>> + * @tried_mask: bitmask of already-tried variant indices; updated on each try
>> + *
>> + * Iterates the full read variant list in descending performance order,
>> + * skipping variants in @tried_mask, and calls execute_tuning on each until one
>> + * succeeds. The fastest PHY-tunable variant is chosen regardless of which was
>> + * pre-selected at init; ranked iteration finds the best available variant
>> + * without re-trying already-attempted ones.
>> + *
>> + * On success, sets spinand->max_read_op and updates the matching
>> + * odtr_op_templates.read_cache or ssdr_op_templates.read_cache.
>> + */
>> +static bool spinand_try_phy_ranked(struct spinand_device *spinand,
>> +				   struct spi_mem *mem, bool odtr,
>> +				   u32 *tried_mask)
>> +{
>> +	const struct spinand_op_variants *variants = spinand->phy_read_variants;
>> +	const struct spi_mem_op *best;
>> +	int ret;
>> +
>> +	if (!variants)
>> +		return false;
>> +
>> +	while ((best = spinand_op_find_best(spinand, variants, odtr,
>> +					    *tried_mask))) {
> 
> Ok, now I get the mask.
> 
> Why do you care about odtr flag at all? We should just take the fastest
> modes in descending order, I don't really understand why mentioning odtr
> is needed? Maybe your goal is to make a faster loop, taking the fastest
> mode in each case and compare? This should work in most cases, given the
> fact that we tend to order the variants by speed, but they are not
> always in perfect order. I already faced cases where faster modes
> appeared to be down the list because of the game of dummy cycles. But
> that is probably not impacting PHY mode since we are using the fastest
> speed (with only the mode with the maximum number of dummy cycles)
> usable.
> 
> So in the end, if you sort ODTR vs. SSDR for optimization reasons, ok.
> 
>> +		*tried_mask |= BIT(best - variants->ops);
>> +		spinand->max_read_op = *best;
>> +		spinand->max_read_op.max_freq = 0;
>> +		ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
>> +					     &spinand->max_write_op);
>> +		if (ret && ret != -EOPNOTSUPP)
>> +			dev_warn(&mem->spi->dev, "%s PHY tuning failed: %d\n",
>> +				 odtr ? "ODTR" : "SSDR", ret);
>> +		if (!ret && spinand->max_read_op.max_freq) {
>> +			if (odtr)
>> +				spinand->odtr_op_templates.read_cache = best;
>> +			else
>> +				spinand->ssdr_op_templates.read_cache = best;
>> +			return true;
>> +		}
>> +	}
>> +	return false;
>> +}
>> +
>> +/*
>> + * spinand_reset_max_ops() - Copy op templates and zero max_freq on both.
>> + * @spinand:    SPI NAND device
>> + * @templates:  op template set to copy from
>> + *
>> + * Called before execute_tuning so max_freq starts at zero; execute_tuning sets
>> + * it to the validated clock rate only on success. A non-zero max_freq means
>> + * PHY-validated; zero means the base rate applies.
>> + */
>> +static void spinand_reset_max_ops(struct spinand_device *spinand,
>> +				  struct spinand_mem_ops *templates)
>> +{
>> +	spinand->max_read_op = *templates->read_cache;
>> +	spinand->max_read_op.max_freq = 0;
>> +	spinand->max_write_op = *templates->write_cache;
>> +	spinand->max_write_op.max_freq = 0;
>> +}
>> +
>> +/*
>> + * spinand_configure_phy() - Negotiate the optimal PHY operating point.
>> + * @spinand:    SPI NAND device
>> + * @mem:        SPI memory device
>> + *
>> + * Tries the pre-selected variant first.  If the controller signals that
>> + * PHY tuning is not applicable for that specific op, iterates all remaining
>> + * variants in performance order.  For devices that support both DTR and SDR
>> + * interfaces, DTR variants are tried first; if all fail the device is
>> + * switched to SDR mode and SDR variants are tried.  On full failure the
>> + * device falls back to the best available non-PHY mode.  Devices that
>> + * support only SDR skip the DTR ranked pass entirely.
>> + *
>> + * PHY failure is never fatal.
>> + *
>> + * Note: tried_mask is u32, supporting up to 32 variants total across both
>> + * ODTR and SSDR. Flash devices with more than 32 read variants are not
>> + * supported.
>> + */
>> +static void spinand_configure_phy(struct spinand_device *spinand,
>> +				  struct spi_mem *mem)
>> +{
>> +	u32 tried_mask;
>> +	int ret;
>> +
>> +	spinand_reset_max_ops(spinand, spinand->op_templates);
>> +
>> +	ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
>> +				     &spinand->max_write_op);
>> +	if (ret && ret != -EOPNOTSUPP)
>> +		dev_warn(&mem->spi->dev, "Failed to execute PHY tuning: %d\n",
>> +			 ret);
> 
> I guess we don't want to warn in this case. You can keep it as a dbg log
> if you want.

...

> 
>> +	/*
>> +	 * Any non-zero return or a set max_freq means we are done (error,
>> +	 * unsupported, or success). Fallback only for the op-specific "skip"
>> +	 * signal: ret == 0 with max_freq still 0.
>> +	 */
>> +	if (ret || spinand->max_read_op.max_freq)
>> +		return;
>> +
>> +	if (!mem->spi->post_config_max_speed_hz || spinand->bus_iface == SSDR ||
>> +	    !spinand->phy_read_variants)
>> +		return;
> 
> Why not moving this earlier? (except the SSDR check) this way we return
> even earlier if the tuning cannot happen.
> 
> I am not sure I understand your use of phy_read_variants here. Can it
> really be NULL?

I had a look at it, you're right - it can't be. Removing the check in v5.

> 
>> +	if (WARN_ON(spinand->phy_read_variants->nops > 32))
>> +		return;
>> +
>> +	/* Mark the pre-selected ODTR variant as already tried */
>> +	tried_mask = BIT(spinand->odtr_op_templates.read_cache -
>> +			 spinand->phy_read_variants->ops);
>> +
>> +	dev_dbg(&mem->spi->dev,
>> +		"PHY tuning skipped for current op; searching for best PHY variant\n");
>> +
>> +	/* Pass 1: try all remaining ODTR variants in performance order */
>> +	if (spinand_try_phy_ranked(spinand, mem, true, &tried_mask))
>> +		return;
>> +
>> +	/*
>> +	 * Pass 2: switch to SSDR and try all SSDR variants in performance
>> +	 * order.
>> +	 *
>> +	 * Only enter if we actually have SSDR support and a reconfigure
>> +	 * callback.
> 
> It is not possible to enable ODTR without the configure callback.
> 
>> The hardware is still in ODTR mode here so no
>> +	 * configure_chip call is needed to undo; just set up the ODTR non-PHY
>> +	 * fallback and return.
>> +	 */
>> +	if (!spinand->ssdr_op_templates.read_cache ||
>> +	    !spinand->ssdr_op_templates.write_cache ||
> 
> I don't think this is ever possible, is it?
> 
>> +	    !spinand->configure_chip)
>> +		goto use_odtr_non_phy;
> 
> I don't think we will ever use this path.
> 
>> +
>> +	if (spinand->configure_chip(spinand, SSDR))
>> +		goto use_odtr_non_phy;
> 
> We should handle chips with no ODTR support. I'm not sure the logic is
> robust enough for them. Have you tried by commenting out the ODTR
> variants of your chip?

Didn't try this, but yeah current code may not be robust for non-ODTR
flashes. I'll look into this and make changes accordingly in v5.

> 
>> +
>> +	spinand->op_templates = &spinand->ssdr_op_templates;
>> +	spinand->bus_iface = SSDR;
>> +	spinand->max_write_op = *spinand->ssdr_op_templates.write_cache;
>> +	spinand->max_write_op.max_freq = 0;
>> +
>> +	/*
>> +	 * Only ODTR variants were candidates in Pass 1; SSDR bit positions
>> +	 * are clear
>> +	 */
>> +	if (spinand_try_phy_ranked(spinand, mem, false, &tried_mask))
>> +		return;
>> +
>> +	/*
>> +	 * All PHY attempts exhausted.  Revert to ODTR for non-PHY DTR
>> +	 * operation.  If revert fails, stay in SSDR — a mode mismatch
>> +	 * (ODTR op templates on SSDR-mode device) would corrupt data.
>> +	 */
>> +	if (spinand->configure_chip(spinand, ODTR)) {
>> +		dev_warn(&mem->spi->dev,
>> +			 "Failed to revert to ODTR, staying in SSDR non-PHY\n");
>> +		spinand_reset_max_ops(spinand, &spinand->ssdr_op_templates);
>> +		return;
>> +	}
>> +
>> +use_odtr_non_phy:
>> +	spinand->op_templates = &spinand->odtr_op_templates;
>> +	spinand->bus_iface = ODTR;
>> +	spinand_reset_max_ops(spinand, &spinand->odtr_op_templates);
>> +}
> 
>>   static int spinand_probe(struct spi_mem *mem)
>>   {
>>   	struct spinand_device *spinand;
>> @@ -2072,6 +2254,20 @@ static int spinand_probe(struct spi_mem *mem)
>>   	if (ret)
>>   		return ret;
>>   
>> +	/*
>> +	 * Negotiate the best PHY operating point before creating dirmaps so
>> +	 * the validated frequency is available at dirmap construction time.
>> +	 */
>> +	spinand_configure_phy(spinand, mem);
>> +
>> +	ret = spinand_create_dirmaps(spinand);
>> +	if (ret) {
>> +		dev_err(&mem->spi->dev,
>> +			"Failed to create direct mappings for read/write operations (err = %d)\n",
>> +			ret);
>> +		goto err_spinand_cleanup;
>> +	}
>> +
>>   	ret = mtd_device_register(mtd, NULL, 0);
>>   	if (ret)
>>   		goto err_spinand_cleanup;
>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
>> index ec6efcfeef83..50a8319cf11e 100644
>> --- a/include/linux/mtd/spinand.h
>> +++ b/include/linux/mtd/spinand.h
>> @@ -791,8 +791,19 @@ struct spinand_device {
>>   	struct spinand_mem_ops *op_templates;
>>   	enum spinand_bus_interface bus_iface;
>>   
>> +	/*
>> +	 * Full read variant list (ODTR and SSDR ops together), saved when ODTR
>> +	 * templates are valid. Used by spinand_configure_phy() to iterate all
>> +	 * candidates when the pre-selected variant cannot be PHY-tuned.
>> +	 */
>> +	const struct spinand_op_variants *phy_read_variants;
> 
> Why do you prefix this pointer name with "phy"? The variants pointed are
> basically all read variants, no more no less. Even though you want to
> use them for PHY tuning purposes, I don't think it is wise to name the
> member here.

Agreed, will rename it in v5. Also, will keep other suggestions in mind
before preparing v5.

Thanks,
Santhosh.

> 
>> +
>>   	struct spinand_dirmap *dirmaps;
>>   
>> +	/* Persistent op templates updated by execute_tuning with validated speed. */
>> +	struct spi_mem_op max_read_op;
>> +	struct spi_mem_op max_write_op;
>> +
>>   	int (*select_target)(struct spinand_device *spinand,
>>   			     unsigned int target);
>>   	unsigned int cur_target;
> 
> Thanks,
> Miquèl


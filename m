Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B514503B
	for <linux-spi@vger.kernel.org>; Mon,  5 Oct 2026 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791177628; cv=fail; b=Jdhg9U/IgQuSr277spexht58VJo/Hbq/gjPDzezFObR1EQeMwg/NzSXYHDsvdgkwyKyVpC1oJEmUr4LviWRA4+aBjsJI5fRaG4XQFByLPmjiRUMWdvvgSpIofYAXAYi5928mtN4Ogh5G/FkTnsbxcW/Ibe9Mqzrb5ZaqpThlKmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791177628; c=relaxed/simple;
	bh=qoMcEa+s2oEj2biABXbRdvs2pqvTglH4x4x3x83qJ6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ocdsvl2YpWI540lncsIfzcz3/0JaLiqLfy08bUPUN07ETHqN8bL81TWPz8hhIxS8FDh8LsgJU4LIUbWMk2Ujqxz49gg+tIjJHLvWak/Jkzywabjm9yiSopmBwxQzYWvJayrwVuPLaCxw3nRUb+YdFMpew8y6papk05rSld97J6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Uu0937vE; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Uu0937vE"
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6950wVpI3763181;
	Mon, 5 Oct 2026 05:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=qo
	McEa+s2oEj2biABXbRdvs2pqvTglH4x4x3x83qJ6A=; b=Uu0937vE3PrQybgVfq
	tO3rlq3vX10QuVnPuoumkGfi4vLHpx6t64qGm4uqkusSI+0NrbiU1rVYA/5oSb4r
	inKazPHcJQqVidH1npNTXTNWumyCgbgO15IzlZboR4y354a3oEkgE0yM/0391mNV
	VIusB/w4elBILzXrVNt9D57jmugnZtHTfdsw3ooKFktjYWL4Ce3Q0EWBgWapz88D
	RCULioQGQ+YRT2U0R5hrCKpS+d1zKjpoW+CQlHiulkh6tvegvaUluVhyb5/faA2Z
	x8FwE3BYmCpSL63xzFSSSoDC/vxMUvT0PjEiT0EvUKGRQmg1mTa+wTxKvjHF+0jc
	wZzg==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4h3w62bv93-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 05:20:09 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id CBD41D2EC;
	Mon,  5 Oct 2026 05:20:07 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 4 Oct 2026 17:20:06 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 4 Oct 2026 17:20:06 -1200
Received: from PH0PR07CU006.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 5 Oct
 2026 05:20:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ob6J0CrEVD2/4zCZ0LIaEp4aE0SHa74bbYzRnZ6FdwgGOhZkNwWIutFHT5jawXXNsnM78hu+Cpv2j9PivLHCFtkWADPUY8TLrEkETOhjKMCjhYmnABsLYTxcA+/oToW9nL8JiWEXB6SETfZcFOFqleePbGJDwAKhyP9fJPD5lWqyl6loBg6IupSCRT/aWv21YqaPdiKr7J1nX72XEUih2tuThL7Qkk1PjGNhmlWcIvdYuAd3jYbu4miwilpMahbhmcU+Cj/Lv36lMzAUineuI39she5MTEvWY9aa26VA/LiH9geaZiYZnvnYv3dXj6alv8dGg5xybF8FxutJvbpXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoMcEa+s2oEj2biABXbRdvs2pqvTglH4x4x3x83qJ6A=;
 b=d5w+xMrpfT+8nDzYgjxbBW74t+3lR01C8qyvigrJjykbC+rUSuVtg2nzcC0k+7ScAZrMBdo/ji2BbVlQnwm3l0pweNEomo6ho8qk8GtWKFjcrNrU+l5e2K9qeqFXnbySt6fT2QU3p+lUW5E8SzBKjlF2Dk8IwWZQs/vL5xM7UqSPjsYd/MGALpWBOZOH2/jnjp13a/1FWHIdrqyXWYxxB8Ci3WZ/MjpXUyelX/+N3O8444A9XLMZ7n3CmV3VRVeRhThaIYazOd8q9QrZ4ApCBk/uLQK3JSvfA7U/o6EuTyZ3mvnPO3DumHeNYqwASxd6rC7/OXYCGtuuQn4dsflgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CY8SPRMB0033.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:50::13)
 by MN0PR84MB3890.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:4c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 05:20:05 +0000
Received: from CY8SPRMB0033.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8de0:d326:57f3:d124]) by CY8SPRMB0033.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8de0:d326:57f3:d124%5]) with mapi id 15.21.0451.026; Mon, 5 Oct 2026
 05:20:04 +0000
From: "Wen Bin, Leong" <leong.wen-bin@hpe.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: Subject: Question about lack of timeout in spi-altera-core
 polling path
Thread-Topic: Subject: Question about lack of timeout in spi-altera-core
 polling path
Thread-Index: Ad1MKk5cr1IA8tT9QSmw68cXrXGi1AABcBYAAC3oubYAAFgKAAHlux7w
Date: Mon, 5 Oct 2026 05:20:04 +0000
Message-ID: <CY8SPRMB003392AAD2C7932D146304DEBD962@CY8SPRMB0033.NAMPRD84.PROD.OUTLOOK.COM>
References: <PH0PR84MB15263715756E3D68DA63C119BD812@PH0PR84MB1526.NAMPRD84.PROD.OUTLOOK.COM>
 <c2451875-9217-47ef-a8c9-486b9215a7a6@sirena.org.uk>
 <PH0PR84MB152600654436F023F1F5BBF2BD802@PH0PR84MB1526.NAMPRD84.PROD.OUTLOOK.COM>
 <22c2d358-9e6c-4ca6-a498-18b09e34efc9@sirena.org.uk>
In-Reply-To: <22c2d358-9e6c-4ca6-a498-18b09e34efc9@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hpe.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8SPRMB0033:EE_|MN0PR84MB3890:EE_
x-ms-office365-filtering-correlation-id: d8173fbf-ef6a-4f49-072a-08df22a05072
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|56012099006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: o7to/2WHUCUFmgNWylaobQ1nJ38QhArz80rH4Gk19CN6Vsp9QZwfs5rQWrpvux4o3rt2uC3JMvutkFXlfxYy+GvBvhUOvQALqKvcX/Y9ndbW3lpYxwug3gH/NGQe+ON+MSDIjao6BfVRTD/BbIfaqdUxJhtIAOGLAOuXalz07KIvTKNbiWSsagULzHj35HYkuCscveUPbFDtdgDuL/9dskJQkGuZjP3l3VVkS/RNGN1MaCDnFy7z11LdnINK4zRP0TvwnUGOOhDIHfN81ORpKSh7FAUt3Ycyue0mQCS913tVkhO/xKM6VATT9i9wYEtE2WFB3kbAt+RCzEqPTpHKuHGKqt2/ZMqM4Umur0vVUDwVL2nsV1pJo5hkO5DGC95BQkejjX4hfCEPhVy9AXXRCdYyW6l9FizcY6eaYwS6QHMoYUSjfnOUqkvtLd302hhte/WKngW7KecgFxgTiImlSVBr+Do6IEIRqFXIZrB/exMa+s2rMWdyHCpiPxm8inL9P2AxMLodQCpzomaA9zAwDBwzj8YiaXARomiE/9R+2cjomi1klvRzTi9L5QoLnAK5Hp2dKS87GdawscazbkmHJ2SfRG9PVkitBulPu7O6RgY5fsefXqn/Pis5z07KSiPHDoAP7c+LMni3jVcYxjrzpdSI+BJO+uLf2MLM5RApk4tb/KM3PkKZCMJpyjx3IVYW/bxmzhdvGsNINyVFvJZ4k4CbrFTCCIoax9CrrSHJlo4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8SPRMB0033.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0xhw7p4QjKX9gD1sxCFpNEOOmkeehotn2Rs4RYgSDhzzsjnCF1jf61L73k?=
 =?iso-8859-1?Q?+k7SQozuNUPY79cfPHkqKrHJCLdV8ldNYkpfJUZExTqmxGlcPQW6KK07Ss?=
 =?iso-8859-1?Q?0KgWSHlfrxSphVP919myzFsWwIJrhmBSH/FKb/EJp/ZZNyEH0e76I4zGCs?=
 =?iso-8859-1?Q?R8unJNr+1OP+0TchuMKs+yR/0nb7C6r0q2xje/oAp1y19J3TuyVPD5mf1a?=
 =?iso-8859-1?Q?uuEvANKt3OCGn6Vv/iq9jn1qbi9nXqv5WUqzICYjJ4Dju5zZbwpC2wXyw5?=
 =?iso-8859-1?Q?l1QIm/7507ir3+C/MNwP1AtyGui1kGAfaimYloixu0ONyl6P8A08GKvOR8?=
 =?iso-8859-1?Q?2wSxQg1RZ5ZK3/bjL0n2b8PxcygVs6I/6hmTGpmh3d+J5Rb2+aQY7KP+E8?=
 =?iso-8859-1?Q?0GoLJYEHjbIRn6AGC2QanKVv97bylf8ooMmuJeauS5ayzJSUsfXVvkfCm4?=
 =?iso-8859-1?Q?pN1V2Iod2RQfRLWUuiK9WlOv9Kqr9ZMQqZ7et5CHSgLNg1vUfPNX+bsk25?=
 =?iso-8859-1?Q?Jhu2RYOyXQJjbe5JIlzABC/yNBItQgMC/HIKwA9yqklb17mK8wdvfwZabN?=
 =?iso-8859-1?Q?ay5Gn8yCHzS8ttve61t4Vg+TvH2CLVS+nemRzXMfDrnQ1ZkoQJ50v1Np00?=
 =?iso-8859-1?Q?i+Z99DOM+wnGHtKpj6CGVA06PHhWz2mRwB/H0noDoyY6LdFXJv7ZVr/IPQ?=
 =?iso-8859-1?Q?5T612xnj9rFgrTTVmt4TpsK4ltff6BtPLIrcbFI25rIsurNd9KKdl/a3Nz?=
 =?iso-8859-1?Q?YhbOIZ15TPhr286J21MT/pnTOKTI7JOygjaqcU8liToz1gnLajpajU/xPq?=
 =?iso-8859-1?Q?qgiokmPbusyYf+ULMKTTZceg3z5DkAn7LinEwbi/u2phKHhU6gdAYfMiVC?=
 =?iso-8859-1?Q?b4WddkYUe9cwlvCwHxw3tojeluRyjmsoQkLRrTNGEI7uiJcyP99kHgsnXG?=
 =?iso-8859-1?Q?O44DneSu0Dc9GhHNvRHVApW47FM0MoC1+ruRSylY0F8p5BnbBdCyfrxKiD?=
 =?iso-8859-1?Q?/kOlLCU0ucV0U3E3QVqCQ/i5jXhm7LrVy9gvBlpYCtbOnSV511mQlX5D7N?=
 =?iso-8859-1?Q?XP5Zb09oNYIgLQyGmi5I/uGTbfyWck+6GjD5oFOgLFML4um38hnuNHZL4V?=
 =?iso-8859-1?Q?2bOsrUGUmPnQ8eWJR+W6H7OqnT4v4qVaVSAJwd80QHQgMCvAhCRawHsmNe?=
 =?iso-8859-1?Q?ply3BIiUqLUSjGxuel8FfCfx7ZsBo5ekEe+JbJMT/n4900udOkJPKzL33b?=
 =?iso-8859-1?Q?d09Ozgm+VMDluHTfSSw2EeY3StkvQKXZ2+H2Kkak+VHQrd810gKdXIgjob?=
 =?iso-8859-1?Q?9L/pRcApZPp3NwMN7dwItKjFXHXPfg2WtDP0xpbR+5d+KlR4SuQu9fDlic?=
 =?iso-8859-1?Q?slSvX7A7zjyCXvTlEhQGBo6zNkRNBIup8JrntKz8sIivHvMe5Q7PHbEM3m?=
 =?iso-8859-1?Q?OW7bgUilcaPepE8e0P1VShtcBAYBbFqSWf/E4xQBjM2NP/340I7hvjVLx/?=
 =?iso-8859-1?Q?7xLCiRVQJeHwPKxhC7brAjQkeB3KRs8ZcdmtYxqsRtLWM7StIoG0Z341jR?=
 =?iso-8859-1?Q?eNGF8qweP58E+5OciHOVFw07SQZmvrJ6tshXpq03oPiZFm/G3lVbyqBj7k?=
 =?iso-8859-1?Q?E5kusQf010M+Kexc0BzWhWdoom8iaOcyg+u/cloaPVm4xsoHJyW5G6pQ81?=
 =?iso-8859-1?Q?lsPyf6Kksu7IPcX4uNlJjTA9YWZBs+2Nrv/bSwX29vU1ZkZCVd3WzuTFAo?=
 =?iso-8859-1?Q?0wPoe9yukwMKbJx6n+Q84yeRtg8AFOvMA27mJr/f87jLx9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jkJzj0j7Zax2Ggy+ENiKHhSQbgvG5y6imMxzy895rB2dTaCv7Rq/JNfp1tUCaNNJJC0MesM9BjXGOSDd/VfyEIrMoqiN0xC0brIIBOqycHqMq8CO+if27m+0HSI/f7eeYG6N/ZPxFUiKv9YZ4IEXmx3Y3kXIvYITBhgB4eWlUlZMBCgp4bXm825TJBgHKGQXdIJY6q/EIRZtAYDH57irjAoGB3ANs5FBEu3PsTNYh62QO5DdGPWUDcYSHQRloeilt+bM0fw34F9DRG4JFtgpGlu4nIyAq5vbzYoKMiHYLEL8jlOmyCMqZ0/WmIytocRq/go3VuQCX+yNBIGCzH8Mag==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8SPRMB0033.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d8173fbf-ef6a-4f49-072a-08df22a05072
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 05:20:04.9019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CO0rLo36ULrKWzXfxOGHvaeCc9ZRvW+KVfotyilD+n9Y3RLYeicXzxK4Nt5d94qcm42lAvZBz9NWMXmxb+QYeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR84MB3890
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=APP6TA4N c=1 sm=1 tr=0 ts=6ac33389 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=NCWKwCw8Xy9Og0ibBRsL:22
 a=I6k9sHShu43ZvcpXNAwA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyMCBTYWx0ZWRfX5LHtyuPCfxVU
 FbxVmMSLzF4bY5SidCjLuWplWxbPSqiuBE0RQaZcra0Q1mox2plgXEEtAAWchG8NntTBRR/U21Q
 0SVYEAOARxgwqJkXSXpBQzbxNdVJSrrVKojlix3QZfn7pPgIc3/YpmFOPH7b2OsIym1X9yUKJ+u
 3QoyiS1YdQD4wVSHON/b0Z60XF2y/ZGRoblXdogI5/apSZEyb1iAfCa1Dr7TgCL5fK809nEb0P4
 RaRiyS+CI0P2vUxycfPRLv9zONiofkQsmMKePZPT6/IF5A56UKMfwLDnRtHDKMMm7OGKNt/FPC8
 iP1CnfaADoPh9wy5+KTnGm+DsMytY+g5OKakZFUbhFl3nnbi9JANlMQb3bt9jNZuReVD0+A+uNT
 jMVvaBt4TeSEsmPitPpsdR+ON0+2KzsuOtiFI3Dte/ClW6Q9/n0Blc+rFgwFMr5mU0Yk8AgFxIc
 l76CFM8kYWS7AGBMINQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyMCBTYWx0ZWRfX4aGvxINcIaD/
 qZLc8dgfWK+1krZrWs8o8rtfutOFuduYs2EsJ6thnvrR/QnpeaWK4fcSr5UjtrQemArg3f8Aslx
 g81oRX8ci2vojMN4EZ2O+Zes2p0ComE=
X-Proofpoint-GUID: QqoIuCUO-IcZEZSLUYAE-sojWzieBROL
X-Proofpoint-ORIG-GUID: QqoIuCUO-IcZEZSLUYAE-sojWzieBROL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050020

Hi Mark,
=A0
Thanks for the clarification and the feedback on email formatting.
=A0
I've submitted a patch addressing this issue:
=A0
[PATCH] spi: altera: Add timeout while waiting for RRDY
=A0
I'll also ensure future emails are sent in plain text with appropriate
line wrapping.
=A0
Thanks,
Wen Bin


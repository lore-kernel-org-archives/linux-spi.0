Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F748640B
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257290; cv=fail; b=Lr2pPpWVFdCP4vtpciRaxNyM3BhKRUtDQDb33ULWFUpjQRR3lDc1LKmP8c3WxWPFSuZozAzpJo1d/mLGGtUlIOTZ9Jxx8N9QDWXdp2zMaBCnThHcr0DaUQdPy/2Rd/3fGKB3b8oriX1p/Fyh/AN+zTZfKbodC/eoP7Z97Qnn1rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257290; c=relaxed/simple;
	bh=xpxItxgR6JMteaepe13mWFRIkzl9ViN54o7uYhTB37s=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IYbmsQuLI6F09RhqGPWdxmpKXGrxjFxG58o2rgn7K8fMUhYCc2AorJvqsCf2anZM5AbIjq0ZBTqQ8y0o3BhjZ9HnUcyYS1N25jSC8uUauo1QQ3kHV4YyDVtMsEw5BxuuIMi8KBJY1rwZwkJ6/DmEDpj7G2zpzqhy0vMsxPQoy4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Hh7Od4SD; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Hh7Od4SD"
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OD4YWQ725920;
	Thu, 24 Sep 2026 13:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=D+e2BUn+5rlHLoikq4lsiMjd
	Ws8Um3SYvq+RHwqu/4Q=; b=Hh7Od4SDQLUFp2wKAq4xk5evT7pYA6bID7SSsqKc
	omINLWoZ09t3r8PmJNdETgGJPA8yAzHRsNr1n1DyiR/RQAaBztFYs8sHWn3x6A6U
	tn36AtJK8qMpH9JXhb5nbotYoULx843MIZk3dC0U5xZag8Swi+DwE8KzPuygQKJx
	GEtODS0VSiABREHQIVWXk+ESJDHF2j68+vyM+yHNjFQUVoUW86qAbzw2RX3+7Bpo
	RYT1oLJwRUZnlgZ89SF6xGXP8kvD4E+NysGw6nudUyx5lM1HiMqmTAEdKroIaTKD
	++nZkiAaorDtloFvwus+qQMdouWqZuOaRqp2UEnBMc6X9A==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4gw2x69x6a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 13:41:19 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 0BE09806B3A;
	Thu, 24 Sep 2026 13:41:19 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 24 Sep 2026 01:40:58 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 24 Sep 2026 01:40:58 -1200
Received: from PH0PR07CU006.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 24 Sep
 2026 01:40:55 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGEmqXyeBbnJlS/wLv/XfLuA2YdNyrnOU0b70IXPWiCY0LaH/8ay2ycIf14n+kJQgGohLurGXdhiC/r/2CTSxD3XEG3P+P02ATMaShqOz/S9WjWLmi+eAWcbdrDCGmZybnkf2qFLGeEMBlFYlysSDnFxcGtmel5tAhrNXD9XsyEDMtJE3AWfJSr6FBEHrrb2ANgnyBIo0x3GxzJOWPfmheaDjfsdU2/Dmid1nUVCOdiGlO8iM0tvQQZ/RrqRMGPqj2q/PLF/+YjVajF1CxchlJSGiGwmcYmM0pgMcDGw4oXllL5pK2TGWa/OX41u3RcSfH4eKx4I0w7XgC/aqrEzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+e2BUn+5rlHLoikq4lsiMjdWs8Um3SYvq+RHwqu/4Q=;
 b=Q6bQP9mQ9lYifWdxecc3aOI8+99QWvzigbzh6DG/FheNi5WfUpJE8U9yvnBBF1nfLKiXwMQ1eeBhIRyO3C855Fc+0wpqzvC9DnNLI2hJTLNJX8WgLy8jVaTAPOZfsbs62S46KDdKGKZ3XII9jKVXMOvkpU3m+cE02vHA1Z3wl640KzgwDPtL3xP+35+PM656HuFNwuX2JRGpNv7Sco4ktqujvL0wDKN4UG/bC33X1i/n2bX1+tM7K7BZP8K9J2ra1/+m89U7DNSjjmXlslK3XAc21XWpMdulPVL+y1UVzf/mq1HM3BG7rJ9k4w1tAOi3RiPPzPDP2r0faSkIicw28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1526.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:171::12)
 by PH7PR84MB3131.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:1a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 13:40:54 +0000
Received: from PH0PR84MB1526.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::226d:fa42:7df5:447c]) by PH0PR84MB1526.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::226d:fa42:7df5:447c%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 13:40:53 +0000
From: "Wen Bin, Leong" <leong.wen-bin@hpe.com>
To: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>
Subject: Subject: Question about lack of timeout in spi-altera-core polling
 path
Thread-Topic: Subject: Question about lack of timeout in spi-altera-core
 polling path
Thread-Index: Ad1MKk5cr1IA8tT9QSmw68cXrXGi1A==
Date: Thu, 24 Sep 2026 13:40:53 +0000
Message-ID: <PH0PR84MB15263715756E3D68DA63C119BD812@PH0PR84MB1526.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hpe.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR84MB1526:EE_|PH7PR84MB3131:EE_
x-ms-office365-filtering-correlation-id: 35608d4d-cdd3-4940-6937-08df1a417480
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|56012099006|18002099003;
x-microsoft-antispam-message-info: obRlNjUKO5iBGgwIZKsEPjfcallmChDTRFkPxV6KzVmikTd80UDWIUsLZt2peOfUtm6YtYFtyX+ZiUXo4ZvvhfcOkC0vwVEDUlibEu+F62Q9IjiRuY4lWFPM8d0EVjE5XYQVKzHakhPBQKoZo04NlUK/zcoSaJik71PbFURgi4MAwvzfqWyposlhBXC0KUwWiBSGrCOT0vit5ZIwDl3Lgf5dXlqvMXJeuxxSSx1Rl70U7S/kcNFZo3Dwc+nI86sIV3wudc1YSNL8MEn1JkpWZkqDThUi9DthH+L+1RQcka+K01EQD0o5/QnCzCkc+8lsXY72xUdz1/95YwdiJfAE8qQbne3cRUpDvzga8Wm6iALz4LAIudNk9AY3i2icIUS9sE4SNDLSc1y8py26O5Up48Vtp3h4N5EUunNCObhTkKMNr/zX82fbRAYV4UQ9ywtrf+KF/QNwfqzDb2/Lc+SFJ+PrHm4mQnD5QvQqhurIWYlWPO4LxcArP28tAmd5s9UrpvkpUoteNI36+h2cKX9vvc2VNeG1WX3UPzjih/lDF6kMhxX/eV6mEQpUvkz/ogRw+L0F/x086YzSASIW25m9cmsGznIWqGaOLEmqEQu5rEc2d88XRVSVGvJP+xWyvaUwakEX/xZragvml1fA5FMUO2XtP0c86rzskeFccz4a9CypOc7oHu1ryK5NDwrwDWHpte6rlTJ4pKDkO4EywoJ3jdJWfMI+ogyd26QRonBgxtY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1526.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wp8ClPZ1H61dPBzhfZtFafSw4dAKzbt0z0Mv2m+QZJWsmkB6ZDKgn5f1ST9F?=
 =?us-ascii?Q?MmXoPqwviwFwWG5+hkbtjeHXXfgpAPCxqnJH6dxn9s4mK5JyEuZ1knHGry4l?=
 =?us-ascii?Q?zgvb+0Bc+plIc+Bf3AuKhdMudky4mbw/F18nLscqFqkDbNbXOO9BkV4PdILu?=
 =?us-ascii?Q?+dNYmYbANcnIhmSNVUc2R2qGCRu/E0feIDwsXYSlC2/vf3zcIl7OlEf+/kpo?=
 =?us-ascii?Q?B2rVHs6U3nLXT6lvyLRiEbEWQuLBgaKGcwODfS6bEjWJrBkNL30ac4DpeDpX?=
 =?us-ascii?Q?YhYsfTwskVXw3NyeqbBDTQTzYvNFs990LmO9q3gDul5v/f7uNLPbF2z4TQqr?=
 =?us-ascii?Q?C4QD1xhzXUaktTFw7WSWtVQAKryKNIA4bIvkpwntttH9YHjCW0644jvgQC1i?=
 =?us-ascii?Q?WPDUmN3kiuW5eLw9K8r8G+OmSxbrNnyWY+DlGkb3EiXCfHs2tasZI9fOiTXV?=
 =?us-ascii?Q?je7bHFDNnoJ5P2XVasUt0UPcuYCs7ORGDDWc8pdpRu9wKAjs3u5T2VBXpDpU?=
 =?us-ascii?Q?KCyJjgIlVoUZ1+7bxYZ+4LUf/xdHPbU7j3cY36e6/AaT0K0pBHq5aCyKObp/?=
 =?us-ascii?Q?SV1t5G8JWKRVyBKvedTwBY0VuqYCJ2T0yxFikWkiJO3IxWiqb8BPTFGmHSN1?=
 =?us-ascii?Q?x3yrNpcK9+o5/91Ci8tIWz9G7gk49SFqRAepUA4S3ruDLwfnjsNWYdgTbg+9?=
 =?us-ascii?Q?OiLS6+Fbmaue/qtb+KiSGKfQWGj09RtRJBOlNdgeNFjSEPrKJ0O4ARhGISkN?=
 =?us-ascii?Q?60gs2cpIPxdaGutk1G2MRLRq+E3SYEz6qg+cUkekESEoVsqFCuHCVzAh3Kyd?=
 =?us-ascii?Q?Fajh7dM2ARV7AWbkRGZKnTlbHhejRyEwjbgpOum1NGQx9dO2B6AsZFlF4rXC?=
 =?us-ascii?Q?vpnnFCUz6kzpzqA7yd5knEtQE9SV9XXzO3LHBV+bGTGtHvK7TgixqGVBFgG6?=
 =?us-ascii?Q?mil8aHGOdpjGW7IIp5S0ZjUOTdd7mLKb0Vgq4GA1OCDsYglKE16p93FiDxs+?=
 =?us-ascii?Q?zaS8bl9olm4do3yGj2OyPq1sgP4yWuK59UldpxjyEXG0Bvi5YM+G6gPzdtWy?=
 =?us-ascii?Q?/oHvnOwJDdhMy24jTehVQyiVa62hF3GFzjWlqbo+01fUH98lwsCqkUXqr5st?=
 =?us-ascii?Q?eVXH+xnH8u+UwuaaF9EgTZZw1aOJYjIKwq6PtzK8Gs1nwJiOoSsnrMQZfjDK?=
 =?us-ascii?Q?v+j4tnk6kg3NzB4P8RYbyDz+sb5VaEuzo5kH1QsUx77HEf0Q6zQOv52foN3R?=
 =?us-ascii?Q?99cxfDbabKdbp1xSjHnPoZIqfo77NSBlrAN9DJvCftZH4TtWDaxGM9FujEy6?=
 =?us-ascii?Q?yGvxn7HwBj5wuKBC4M+A1AM6zyU+aODW6Vq+Yy2THXsHo3vm4VZ7EsiTY+iJ?=
 =?us-ascii?Q?fZ++tcnqouhitg+HbEn8fB4GNoQtsMtU/c/QwsOjvFG4SZLBAzwfva5GUt1A?=
 =?us-ascii?Q?c+MqdzYykaA/0DGXejbvBPqCpIcxrybuuf+GL90JLc3RkmxVJQvtIFU6s1Jx?=
 =?us-ascii?Q?iQ5mPBIS8YHCM9lLbsr8nWrvQ+QcWOsCDmRObAv9JLb0uAl1wsWzopQGrx1W?=
 =?us-ascii?Q?8Y74wgblR1jac7rknmDQW2vus9Y1otVCYtmbW38gZE7eoFXk++gbpbKbktS+?=
 =?us-ascii?Q?P5FiKyz/diVNpepNP1Fy2XF/cVFh2udXWQXm6klHjffsMqQWarK/MsPGAn8j?=
 =?us-ascii?Q?hKEVJJb/9p5YIAQLovbElURAL2bAvqEEnkdSwpa2OzV5C/Er80PNI1YKMihf?=
 =?us-ascii?Q?yUPkTLiTVA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lKJ8zjVBVN1dSqyD1Xl7WsgNqUplNZd8KoymVrKamnVMUYe8HG+HQe/l2ABkviz6zeTZ/SA44nC4juJRbyXC2ClJEHM4iV/DS5684wuztr6wcmdLY91tB7YqUOj3r0x01dvl6yYHoFsEj599fPhoHn5ghLEXsFYM89zwE4Ha0gdnfjW+zDV24kICKgYfUjNYoZm8pr/vQ/MWc3TCRo+7ONbuHOvh6teWKLOQoOxkp3VBHsBEyDoSiQmEvPdyksNrwx/J7m77nzkF/bH0mrKmIh8zTKvWuqrJGHSjI6pn4Z+oA18wy5zt6V9vCSytDGO2/NwNfAc6bFe5vqx8j4HGJw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1526.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 35608d4d-cdd3-4940-6937-08df1a417480
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 13:40:53.9152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNgdiqgU+E4c8dnGbqQwWd9f/zKQhxNJV8V4gxsAagRUxI0/XDz4GLhzKQxVpew+w9XhWryZ4dZEbUqsUuI/8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB3131
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfX7oaOT8XvcjZH
 oy7nimhIThyZ+roLca3A8UxNwn1pnJRge2iXoPwBW2IXmDfiZtBxZ2643EN5iQiD9lkBNjEzT6j
 wwISIT4Qhss8BRXFlRkGX4kYQ+mQT1E4Im45aZ9oM3a7MDpnZs3jGbunF0+9mf52x2C1314CTK3
 1jD2P+7vjWPUnBSpRtIMWRdh+Z9A13UHWQi2xoxtsey7OhZRC66R/7oXZfRq1Wwp8IsOzYWpEp8
 YNPjWiXUQS5ScaySJjntN5vd0+jeZCls3KTQiiPAwPRB/rp2xt/3sDHmgzl8tGzjEWqDUvjPyWH
 JNz2hd21pxKARjWW/WQ5EswoUdtOMhIjgLzc9XvAHgwOtani41zJ+m5fGe4hRAwfnJSyf3Z9KVT
 BMDx+DYc/W0wPsgAQm5W/92iwqwVlPzMcvbJzWKDINPXxa+XI6GwCwDBAJdkWcRjd3cl6eCdSWd
 W5tlcqM9I8nKl0opoCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfX0jS27PH3irOJ
 Cdj/W6nYW16E8bIRP4wU4mfAhJRBtE2b4NWCx/zm+1uKwd2jlqYtOBM3WhOInvOD+JUOpiu4uX+
 ylvZXeEtdHZ6Ou/9fXSxQKLmGzMerss=
X-Proofpoint-ORIG-GUID: vejxcAAo5pglVLBi9A9Fzj2arF91Efnl
X-Authority-Analysis: v=2.4 cv=SdVi5fRu c=1 sm=1 tr=0 ts=6ab5287f cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=J0OTuHAx6l5K1fCpvPfz:22
 a=axK_fnzm9WqtVwmBwEsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: vejxcAAo5pglVLBi9A9Fzj2arF91Efnl
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240056

Hi,

In drivers/spi/spi-altera-core.c, altera_spi_txrx() waits for
ALTERA_SPI_STATUS_RRDY_MSK using:

    for (;;) {
        altr_spi_readl(hw, ALTERA_SPI_STATUS, &val);
        if (val & ALTERA_SPI_STATUS_RRDY_MSK)
            break;
        cpu_relax();
    }

There is no timeout on this wait.

Is there a hardware guarantee from the Altera SPI IP that RRDY
must always assert after a TX write, or would a timeout and
-ETIMEDOUT handling be appropriate here?

I'm trying to understand whether the infinite wait is intentional
based on the IP specification, or simply historical driver behavior.

Thanks,
Leong Wen Bin

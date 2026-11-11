Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794403352;
	b=trg3khdxmabCfEn60gypA1EqQK71kl/sJSGsYpmhTjZOlbIDtW29imZPuMXHrRcfgOJM
	 +rE8xFPw2NROrV9YWqxy4O3e5te7G6yhxdT+FcFLBmUE61as4a8x/ssppn0Y3LYSxH6w+
	 fYGNbzSEB1/39opg7w0vSZ4X2Hv040e5vFFq3JBO5036n2gyelD4j7ubZwYin6kjQjUY+
	 l4IZBiJnBTrAIsLViNauVy6YGj5bvD0hPPNO+aQENz40iPYZp2OpdaxN6NKNWdwrqRCEy
	 u6AvvwKv4cyyYJZGcogFrTloFnpvjoLtDBRbIv4vdAWGy6wylhoVMvppZdVHU7E9LGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403352;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7wGkLsN3pqOzjSnSciJ/8flzpWDpXBOS2oPjO1Vdzio=;
	b=b/GVvTFDcBzCeE4R4LKN4v+K9z9JgzOucBN7akHsfYqgcKnEpqpyQSXzWZRJ8RBbup8r
	 eBk4zDLP6xgsGUflP1/YHOn0G3JWJBFvcVnrs2m0F5Sx0W1Q2usFG1+1DfwpkjSgiGyH2
	 PsexZsBlwoaeWO+L2hf3eICyP7zs3NF4xxuTBARbH1K4efjIsy0Kznh17AwOdOavdq/52
	 w5ZJTEtsIjcdT5cNL2SaaMf+7cRXWhjliNkiD1bWq/jW3OebYOvvsLXlOWuH/ReBdIkQ7
	 1hfnYf15G5QZQkyKf4sQqk76dhf+rfD9LsUREcy7tDCQPnG6y8dD8ul/UOi1Ro7hj0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=eYhEmsbb;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=k3QP4Sxq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D860A260B;
	Wed, 11 Nov 2026 13:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 583D860A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=eYhEmsbb;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=k3QP4Sxq
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCWQdo347151;
	Wed, 11 Nov 2026 08:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=7wGkLsN3pqOzjSnSciJ/8flzpWDpXBOS2oPjO1Vdzio=; b=eYhEmsb
	bY3kjQ8gwHeIQpJJucxT5COT/63zb1netLtODybdKj6Sbs9i0oxC3JMKlrjcREe+
	6Y5KPRme5vEITjJpolsqzb0nx1bLYCkCn2R9KRm/qQ28DtBZbexQeaPeF3hNos0u
	GMfezsQoXe0uH/wybCn8cljkCSGpoW83N1WmwaoB/MIJshemP40/ngBZlw81O/vi
	yiZxqWiEIuGlsGy6t8nXTJ6rEBSAdumPiLMaFqmMknqws1Ta0evh2Wwwq7PDXBia
	NKzSis7BJROnmtwLucukeCYnMRy98Xte4UKR8FgfzOsOr7EwTaFbinPw8fLLFNU8
	d8twE+OR2sjJAvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7wGkL
	sN3pqOzjSnSciJ/8flzpWDpXBOS2oPjO1Vdzio=; b=k3QP4SxqK1nRN2sg/iQx8
	VI3StVHtEpBRERG8mErY7VF6c16u3wQleyAaCN5YPmCvB3e3lzSRCPgGizJwebAX
	7P3rjifDOEqn+32J9xh1xtnFRIJSoXRNfT9m7baoXP2avgLApdSi6OHrCXwPmbJD
	1pT5U3pSXL1/bUfNT2+KSR8jxK7805zx9lUFQkZFgVZtdhfrUAxclAaV+KLgmrhT
	bL7dhBzRrrcKsRQO5ll5JcEkvgR8NrUQ2OK4iiU1Sh5IUcmuNbbClcuL6lLcqkP/
	lryP++QGLem1H8adLxASOQUnMVTA40SRW24XPwEQ9Sf7SRdxKj1RyfHZETYBZZh9
	A==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hvg57u00t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:21:59 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3W/1qJ71xHRAB8Va0zgFDyt6eEkLFjoE74+4bpZf0Fo/EOx9wWCSbeBkSzPbqTRul12vx7hG1RY0gp0u++/yvYpoyPoLjTsLD/bG2eI+7gB1LRi9+gYhdlcI8BaU/V4U1wuTu5c9Ff2jA+hGhwupCHAuZ6ldjTHh86ESTgMF9Ij0peEmMShE/2X0MvEqiXeW8X0fMS14JtlAQdzRGak1JCs9VRiZJa+L0tVJZ39GuzNDv+COObHj9TdsfvNJNYltPqOJTKIvekmDr5AsDHrpdi7fpzH6gFpza975iqfS1WhicqueQvpGJwpSKK4MkRhJj3mWy115rtYILfURCI+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wGkLsN3pqOzjSnSciJ/8flzpWDpXBOS2oPjO1Vdzio=;
 b=DIkc8SMmje2fzwumpp3avSknLw0Eu5jMjWDu/9BIsUuU8dHyCLQ+eJ2tE/HtPlu1FKbWJRv0MlcYXxAUybP4AmgUL2gANzSJJjhj7LDx1q7j5taUToujaRV0IFmi2cVcrnXcS6gxhZBwOYvrFJBv2o2PR1kQmWcTFrSO5xh8RYbVE9gK+IHbeMZ8awvEi82VBm1fnZSn9z/LKsOl4wKNpu6NQ0fNHYMlAu8zeRgPibdeOiJ6/79I1fqJ36OTjV/v8xsiusiGITDaDqoKW1v3nWpSPMnLMsIQLVTbovyx7qtl02sEolrCECDgAOk9NS0vHQfbCahESaddOfJamLsGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB7348.namprd03.prod.outlook.com (2603:10b6:806:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 13:21:57 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 13:21:55 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 11 Nov 2026 13:23:05 +0000
Subject: [PATCH v2 4/8] spi: cadence-xspi: support clocks and resets
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-xspi-cadence-add-acmd-v2-4-d339046ada8b@analog.com>
References: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
In-Reply-To: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>,
        Pratyush Yadav <p.yadav@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>, Mark Brown <broonie@kernel.org>,
        Jayshri Pawar <jpawar@cadence.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794403385; l=2416;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=50N3LCj2rjrRWYpsNybXEok/YIAkb+gJ/mcbFf+0S78=;
 b=FiX7wAxB+qqsz21yrmKNpxYeEOGyxtfhzk3T+dWh/4sfMrgyw4qHoM2TzsHQwYQ8Wwn+EGUtM
 U3CrnkaD14NDrkdf0X0L0g9zKvCvCX1hu2DM96g/T+jYmhj7RiiHIR9
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::16) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 015c7085-9de6-4909-7635-08df3ff6c19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022105027099003|56012099006|261026140227099003|261021121427099003|261009220027099003|261022075727099003|261021123027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|261102123227099003|11063799006|261028144727099003|22082099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	29ckvszTkVkPzErMrwv0JQWn6DksbpBJYCc/7pCDoAshXyHkptIdggJCTHozxnUp/gSxza5faofgDBCB9UVnuUTIegiXVrmBmWGtQoJuCoKc+FA4ZO8VT4hkv0UbNVYHlf2dPgWWBHsJ+8QzxKE6g2xTN8er8xpoWCkfPpSExlfF/JkZSoFmVcxNUXHsEZFDR6WEj7GCqzQrTbg42XqWFeO5LBY9uODIcpMkTGY85uYEcLDd3ld+qE4eow3wgcUgJSy8/vnZyUYnYMFDxlDVC2PM0ZvQ6H9bLOM4WYUvcRpK9CB9qBNLVb8GAjIN8ZAWaVBaG/8/W3talp6S326y4hzHNUhObYKq+tTYQMGAsbYy3kcyBPW0ByGMr3Kwk6M7dQQKVUk6UdY7y96m/XHAYYjPdr8RmgJEY59XYUa7RbSgtpY87at6JKsPlEpyPvilmaI002KPOXJx6cDTIDzUiUpU8B9AQ/BgxJZyqiPkyS8oRxUZ69jdb0Caaak5nX9aaHeKFVUzCB0RDF5yBoQc59UWRrU4qCOscsDrhFAwlTrnWzBoDyxnkq0agDrfA02Wh/510eBKFOLbZBGIrXxT8gQKl5jBI4kZWI7kVrFvDd0p7WHiX+ZCi23xEsQHKZPWO0SZ85I5SCwMU6K0ckDSpN/hwLDq/+mcN8Gsvil7Muo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022105027099003)(56012099006)(261026140227099003)(261021121427099003)(261009220027099003)(261022075727099003)(261021123027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(261102123227099003)(11063799006)(261028144727099003)(22082099003)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkVic0FwRG9wWHphVDQzOUhOVlhObUowRVZhNG9uQ2FONk9SVS9jeTZWR2Np?=
 =?utf-8?B?R1o4UWhMcTM1SlRpVXVmdUpuL2RJMTc1ank2czNaY2pkYkhENDJzbVdUY2ZQ?=
 =?utf-8?B?eXgwQlFXQUdscXhhcDdQREdkd0xBT1RvcnVPRmg0bVVEUzk4dGljdW9TZjJq?=
 =?utf-8?B?YlFEbWRVVFYvUTRLM0tINzhwVFRORGRyRE5ycDZHcWtvcTlwUkJ5Ky9CMU9Z?=
 =?utf-8?B?aytnL3ZzbTl1bndDWUZqUTdxTGg0R1Vlb25CbHp1TkQ0NjNDYzNzZ1pXdXBB?=
 =?utf-8?B?YUI1ckdGdk9qSnNOTEEyL0JzcTdWS0dWcEkxMng1OVlHYzVMWEwrU1B4dDRF?=
 =?utf-8?B?VDRWM2tmN0R4U3BQVnRweDM0cFdEand1SExuZUd1Nytqd0RsTHNwdHJ4ZW0r?=
 =?utf-8?B?eDR6K2o3L0gvN21zc21kWXd3WDJ0ejhtWlk0aWNUc1czWklhcmFJdHk5dG1n?=
 =?utf-8?B?QVVXbTNteTF6SklKWStGTEFlUFRqck5tUzNKa095ZFpTY1BHL290NVZXUzZQ?=
 =?utf-8?B?azY4NFVyaEgrUHMyTHJETll6NlV5azF3U0tWSzNjRzc0ckhTYWd3ejNjcHQ3?=
 =?utf-8?B?NG8vUzRPdlVIMXJXUVIrSVExVCtLS01La1o4Zys3NVY5d2d4cldpQ2lhWHRI?=
 =?utf-8?B?M0sxWnR3QXJlRzFGQ3hBY1A3ekYwV3BIS05aT0t3Mm4rS0prbm1PVnRpSTJq?=
 =?utf-8?B?VW9HdnNEZnB1Qnl6VjZhVCt6eTgzMlJ4TENuYW80OGdHcS9oYWJEK3NpT0V2?=
 =?utf-8?B?WFpEWlhtL2VCMWhrejJGTXF5RHJZbFNDaVR6SUY5eFJ6QUZEWSs5bnBzZEpr?=
 =?utf-8?B?UmdSUHZqV2ZoQ1NReFpGQ1RYZ2ZPcEFOVFhwWkVqYStnOHlLRHVkTS9odHVQ?=
 =?utf-8?B?K25PMzBrQWNTMDdKRkN6b1F1S25GVzM4NStQS3cxT0pRclJXQTg3YTZFQkpV?=
 =?utf-8?B?VUpleWJlcURZbHBZbHU2ak8vL2NZY0JBRUdQcFo2THdobmhsRUpQZ3QxQVBl?=
 =?utf-8?B?Zy9JVkNiSEtIUmhMdlVKL0QxZTlETGNiVUovTUNrWUcvQnQwc0EvQUlMWWUz?=
 =?utf-8?B?Zi9vbG5NeGNza2VaWWVTT3RYZEpZZm9ZNkEvOWp0VEpVa1dpTzN0THQ5VGFz?=
 =?utf-8?B?M0wyNFlRZmJ4L1QwYjJnWUt2dlp1ZWs0Nk04YktPVExPdllYRzExUmNtejdo?=
 =?utf-8?B?ZTJ6cnllY05HUElNejl1RUwvM2VRUkRrTW1UM0NxeGdrODdBclFTL1FzajZh?=
 =?utf-8?B?eTNmNi9QbEMrdzN4K2NxVHF0Uy91aDNieWZkVERleTQ3TVdrMklGL1VlcWVq?=
 =?utf-8?B?anFoMWhJYnBRRWtrSG5yeUZiOTMvdjZyNzc1Q2NTTUVBdzY5bE9NeVZWdlhL?=
 =?utf-8?B?bmkzRVR5dnhYMTBiZFhaajZkYXJFYld1Zng4R0pINENUZ0NVcDYvaE1JVWs3?=
 =?utf-8?B?Vms0ekdSME1Gb0k4dFEza3FGZ3FwL1NFL0M3WWo3SzIrK0lpQTRrOHBwV1Fs?=
 =?utf-8?B?ditNTSt0dmdnUy9nN1hibmhoblNzOU93VmxRQmlMdE9oL2xkbXNOVi9LRTJE?=
 =?utf-8?B?WDRlNDJPVzVCNWFIcEZpUENVSkNKQkdySU9NODRjRXBCb2dOci9ud1RtcFUr?=
 =?utf-8?B?VnlNYkZaNzVUMVd5eGd1ZFBybE14RE5Ib0FUeGRxZ09HM0srL1FFWHZzT0U0?=
 =?utf-8?B?NzJuRlZDWGR4S0VUajhYVlRDZ0ZsTUR0aWdROHh2UDVOeXVEQWNsTHBJcGFF?=
 =?utf-8?B?TVlraXBiMUJEZlBDN0ZsWlhqWmNsQTVURURvRjRaVlgyQUdFZ0ZhdHlpd1Zr?=
 =?utf-8?B?MjZ3a1pPZVljR2tWOEVzZ25NckpvclBPWWJucGk1bDBTSUd5Vm4vRXBmNWtB?=
 =?utf-8?B?dFlCOVA5YUVzclFEaVlydE1VczZFanRRSloxUHFIbEFKTFJKY2xCbEFad1hh?=
 =?utf-8?B?SzNvZkVpWFFWYlhpR1c3bHptbDBUdFVQL29QeHZsczBSMllhRkxuRStkb3dL?=
 =?utf-8?B?TU1HZE5YNUF4czVUTVNhZ1JvS0ZhdTE3RWppZlVIa1Z1SXRZcm8wWU42LzhK?=
 =?utf-8?B?MXNReG50Z2ZUTGdRKzZ4V2F4ZVVLN0UwRWN3dERISFEwbU5IVUUzVHNYTVZK?=
 =?utf-8?B?dWJiWFFRUVNzTHV2dmZuSU9TdlR1eVFVNnRzamp2bGN0bzhTRDR3UjZOaGdB?=
 =?utf-8?B?QnBqNFNuZ2ZyODJHNk9hMm9nR2p5dVh1ZTF4ZEw5QXdvaDJZMVJxSE1rRHdM?=
 =?utf-8?B?VGpaL21QeUJjL2FJUm1sS0FUUzl2QlR0RTZIUHAzaTRWejVYalE4bktoVjdN?=
 =?utf-8?B?RTNFRHpOaUVXMHFxVjdkdUZweUdZV1I4M0xwdnlIWmQ3eDRqU1BOZz09?=
X-Exchange-RoutingPolicyChecked:
	YkWb0LsHom8g/ZCi8SM9NrKawIJBDT+VbjrEYqDggsZRIb/Q0GXliKCUzFJQRUWuHsixCMwKLVKf5PFIJaiKxSeMVUsaKjd/9ckIuCL8LqeJoC+7L4ko0NXFHuv1tnv8ldpvOCo+K9+4O500TsPE2D8fPkcDmVy7zLWjF+ZQgJCkOdLq5TlIXerxvLsBwrCbE6ARZKOBDU7WsqLk2c01cWiU+iW/Fi3amQSwEb7MB6CA1fE3GK1V9MhQeeX9PckNnFw5WdpPId9ajthWvHxZMZK5tYBVHUkS9LmJzJVN+qJoyXZe5jYRA7MVTfd3qwy/+uTvETLoWgV8uONHpT9JRQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015c7085-9de6-4909-7635-08df3ff6c19e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:21:55.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GA6zytTqKi7UrkUSXorTJRunVV/HC39E7/PHMyxlzhM9qXXlQXZD3FnCuUf61VSZ5pPMzUgncqp1UTnLTQovBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7348
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX/5r5gy8TUg9n
 JTdjPta06feevcfQqcT2l/GdGoU2EnuFsZ07dKkBd9HZkWftozkry39xyFbZw/wfEUEGiDY68dx
 4u3IEObH7tJK0Yfckh20wIJKcoxSm2YlqgtKkgYAzkhJZfiV130te1+e2VwLazx9z2le6oTQlbS
 QGbreUDx2S0OVxIEmoqK4QCmxugqghW/gHzXl+ZZnKTK0vlbY/OoYPDRUZT94+KjGpMYbeq/wqt
 inbSmOdnDcp3+1J2a703y+24akVm2MTS7Es10RyLbXwkqBroNUgtaffkVsy/3TyI17TskycHN7I
 cNCnEE95r1yzKqQnRNu5OB7Ad5QPrjIqp/hONmWzhU0tkdxRmWzK9+DN8TsyjgQKPvyj1rV/rXb
 UrGD7CQqlXemC4Fv+i0vOy7xkvt+/uWT7rH3kH+XcNV53LY6rSDVy3vl24uMw2NwOOmako9wSMV
 NBdbZUm4g2YiGZMH1Pw==
X-Proofpoint-ORIG-GUID: SMf5r_h3iuZJfoRBm_MS98pfaiHLVV-U
X-Authority-Analysis: v=2.4 cv=ZNVCCn7b c=1 sm=1 tr=0 ts=6af46bf7 cx=c_pps
 a=3/9ZW+mBBPtU5+OO10+n1Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=Wo5Xvolh3WmpkaDIYoIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SMf5r_h3iuZJfoRBm_MS98pfaiHLVV-U
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX99bGSVUH76aJ
 YBCVGg0+wYwIXUEMYsl7aQUCsgquuD8oO4vgORmtjrFQDUDRPsAcVwr4LG3isfj1mz9ezzu/0wk
 /E5vjabgRa/dcZWhKKBt8PkX51eAEoJbPTNPHs7QoMm8nHCLD4c3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110053

The driver assumes the controller clock is already running and that the
controller is out of reset, which only holds if the firmware left it
that way.

Get and enable the optional controller clock and, if a reset line is
described, reset the controller during probe so it starts from a known
state. After the reset, wait for the controller to complete its reset
and initialization process before touching it. Both are optional to keep
compatibility with existing devicetrees.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-cadence-xspi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index c02069715153..5d8d102ef397 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -2,6 +2,7 @@
 // Cadence XSPI flash controller driver
 // Copyright (C) 2020-21 Cadence
 
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -14,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/reset.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/bitfield.h>
@@ -1236,7 +1238,9 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct spi_controller *host = NULL;
 	struct cdns_xspi_dev *cdns_xspi = NULL;
+	struct reset_control *rstc;
 	struct resource *res;
+	struct clk *clk;
 	int ret;
 
 	host = devm_spi_alloc_host(dev, sizeof(*cdns_xspi));
@@ -1322,6 +1326,25 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	}
 #endif
 
+	/* Optional to keep compatibility with existing devicetrees */
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get clock\n");
+
+	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "Failed to get reset\n");
+
+	if (rstc) {
+		ret = reset_control_reset(rstc);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to reset controller\n");
+
+		ret = cdns_xspi_wait_for_init(cdns_xspi);
+		if (ret)
+			return ret;
+	}
+
 	cdns_xspi->irq = platform_get_irq(pdev, 0);
 	if (cdns_xspi->irq < 0)
 		return -ENXIO;

-- 
2.56.0


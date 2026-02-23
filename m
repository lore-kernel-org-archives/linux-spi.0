Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE82FF153;
	Mon, 23 Feb 2026 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861840; cv=fail; b=g9ckJdVbYY6h0otVFapur9+5B7U3jla2Qa4kra0lCey/jP9Q7ayJv/vLOfEAmbOFDKiooYYj42+JJMLTdVF2cHnHox9LgCUSz13e4HEkcIfjRjJMgUJlTXxo4Xkwc/3FU0AL91fLH7chl9SHfPRXe+W46Px8AMhLsSYHqKf6Bec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861840; c=relaxed/simple;
	bh=AAydPUfd6r+43vdt2wfoTPFiBE7w4cx/UrHFh5AOZtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nc6X/L53u3/b1fiuYmqKahuOHaSPeaeX/2hcepUkscQrlxO7TqKxFACO5+W+p1b1CxzH52zkIp8DekJ69GUvRHHD02RsFrUOqYrI+3sJyc6zEdHZk6MqLpfKeOIU60Yolwwd0JdFlYUPj01N0h6n5ronMcG1MGakGyOhj/+hoC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=c80XY20A; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=kQR6Ss35; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="c80XY20A";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="kQR6Ss35"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NF9QXH1991874;
	Mon, 23 Feb 2026 09:50:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=MTnGULPPBpVNWCOVN13Xb6AY4r57BeO8vUuKmPmQoTw=; b=
	c80XY20APZOizTax8xovOzbqcQeuAsgvKRZ/fVyTtpqWVnqB91wPMwDmepyT65o+
	SPBELYNESA07WEmnZaaEfjHM3uaFq6laJURLqbBr6o5nKIE9O3f9xFU3+jFpNnFR
	IbDSe87sy34IGyi7uZfLU80tz57y1dtlWD08wzLy/8qFfkYZORrAcvaRzUQMoy8B
	BkeGs1A+YWWx1vM2DlOSpQIUT3NaX+s+oySbncVr2xjrIFWxidQ4/B5YSm+TKg0K
	Cb5mW2ixpar8ELEOOoZYMpOfVksJjLNl4HeaQjldUstYwKUEeU7fvJlkAmy//Cja
	wEEmEWUWph8KK9FF+/9uXw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020124.outbound.protection.outlook.com [52.101.193.124])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4cfb019q3k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 09:50:35 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVJK8oNOIumKNZRxHGo4eWVEboPYQPpRdSFiG/P/MPOD+WO4BUP7JTwqXsgW6oOMH8DQgtTvLHK2U6Byn7p6K4JccyvPUG1GWJnqfp6N2v+u5bEDvgx3AoP7v6S1XVsyeq71gH1K7gFoCT1HanhxKcvrFez1WRJF9shsKsjXtWPL5OMz5K/4dspPQefkSx418fOcMdlwPP1Nqfvr0FYHZVuQ1yGlGdyr1UhtqskevnD3PoZWS8J7KgB0hyOpT53mKbigkaMLJ4ppLMV/lY72R/lmj/fKeoBQ97Fahg8GP0o6WhmCajLH5FJLX9rNWuXvBxLJdoM1c9Tre9O9YWf/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTnGULPPBpVNWCOVN13Xb6AY4r57BeO8vUuKmPmQoTw=;
 b=vcJZcZdAjMBFvZMtBjz++QVxzdIJWp5C3rANVJ96LINhsV+UhBnG0evrbNzDZHu4TKjN/6rj9RCSysbGUEVMlGFJtJY9Hy69VIO5ccdI8J5NhH1RngXpA/LWrgmtpzIvTlDtbplj7Bv2hDkbH8rGb3gH944sKlpdudem6DFIggUDINCU8fiPW2f8XJH5hdI5IR7KQ567IV71CvOJPzwnKQtrV7jvz1gFKqNcvsDAdlBcM9cOMKYaKus367WEiRME/TWLfOsIDiDuTO7q9AoB2+XPmMBulgRPTZ8zY4dmzjjyARSxg3+VppPawH5RUjaebUxcCpgWMs+uyd/btULTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTnGULPPBpVNWCOVN13Xb6AY4r57BeO8vUuKmPmQoTw=;
 b=kQR6Ss35Ib9Li1ZbQ+W5T/KcnIrh18ft+XjUsDS6SirDMvDNz1HmYiPu+A3XG23Jjoa69yioKK/pzZx1V3khsBiUAIqKgidbgAgRGGqvs82N9F5jBQc5tOVzCnbaE35+R0lnVLtSRfkw3ZDZ134qbhEH/E8dof159C9ybN+VUac=
Received: from CH2PR14CA0023.namprd14.prod.outlook.com (2603:10b6:610:60::33)
 by LV3PR19MB8780.namprd19.prod.outlook.com (2603:10b6:408:288::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 15:50:27 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::3f) by CH2PR14CA0023.outlook.office365.com
 (2603:10b6:610:60::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 15:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Mon, 23 Feb 2026 15:50:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 7D584406541;
	Mon, 23 Feb 2026 15:50:25 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 70CF282024B;
	Mon, 23 Feb 2026 15:50:25 +0000 (UTC)
Message-ID: <16fc29fb-f6e7-4d64-91cd-419bb7d42c2d@opensource.cirrus.com>
Date: Mon, 23 Feb 2026 15:50:25 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] platform/x86: serial-multi-instantiate: Add GPIO
 chip select support for SPI devices
To: Khalil <khalilst@gmail.com>, broonie@kernel.org, hdegoede@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc: linux-spi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260215135524.1171065-1-khalil@rentman.nl>
 <20260215135524.1171065-2-khalil@rentman.nl>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20260215135524.1171065-2-khalil@rentman.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|LV3PR19MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a81461-90ac-43a7-4181-08de72f34398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700013|376014|54012099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEh0ZFhuQkZLSDQySzZQTzNrNi9uOWJZbGtPcjNkY0ZVUjEvZVJaMXFVVE9E?=
 =?utf-8?B?aXl4dkY3aE9FV21CclhiL3M2dVZLT3V3cTB2NFM1cjZ3VmhteHRjb1NLUVZP?=
 =?utf-8?B?M05tSU1kK1N5dnJVSUJZdkN1V1RSVlpaZ1JFQjZJYnc1NjJKb3BLMGpmUkp4?=
 =?utf-8?B?aEVrNXBpZTg0bW5QdHVTblM1eU9NR29LSzlzL3grRlpSTUltdHZ2YmVmRExq?=
 =?utf-8?B?dXZMeDR3aHRSekJ4SWQrL0pObUtQYWlEd2xKR2ROY2dobVNVVlkrN2lxejlr?=
 =?utf-8?B?QzlQckVaYVordXBoNkhmQzk4b29FeUFYVDNjVXpRM1Q2ZmxPbktSZ1dtZndW?=
 =?utf-8?B?NHlScHRRUzhLT21nTUFRYUdQRXZqYlY3VHZITENwZ2R1ZU9Cem0wVjBkVUtH?=
 =?utf-8?B?bEFPLytrSU13ZDIzd29YM0xXMXdkNzJWR2IyaUV0cUtZd1VPMFFtbm1CTFJ4?=
 =?utf-8?B?ZHZTcjRFY0JocmVQbVFTRTdDQ1pSaG1rVWVESFkva0pmV2d5OVc4NVdtTFVZ?=
 =?utf-8?B?dEdrdzdzWUtsd1pnSjhIRXNkY2lwMkpNNjBINi9RekNReDYyMU5rbzIwcGV4?=
 =?utf-8?B?K2NIQk55VVRQVUluQWYxZlNCWnZHaXEzS3UwM1R5OTRXOWEvc0VaYmJpWEsz?=
 =?utf-8?B?TXc0TGJ3N2JTZDBEa3FMczdkcXIrZlRId3cydW11b2RUc3VUMlY4MzNTZzlr?=
 =?utf-8?B?RXFkeUtocGFxbkVVL1J1S3VVb3JBR3hYUSsrcE1Xb096d1ZVL3ZxMWpKam9h?=
 =?utf-8?B?NHpiSkRwNkpDdUpJZjNVSnNhdmhwRlIzVGJHM0E3Mk5oeW1md0Fnd0pCYld5?=
 =?utf-8?B?cGhVNGRYa2ZLaUhlYkJLc3VuR0ppdmd4UUVSbkdVNk9kcVN0OXlZZDlqMGtR?=
 =?utf-8?B?NGdrYzM5MFMxK09zUm1yY25QQ1JTVU8wUE94aVdOSU9KNzFEdGZqY2xpUExv?=
 =?utf-8?B?RHJjTitKejEzWmtuNi91ZXhyM0RpZ0tzUXJtZ1RXU3pEdnNpMGZzSXcvWnJR?=
 =?utf-8?B?dHVNdk9PellCWmorR0IyZStQMDNzMGZ4bS85UEg4OE5BWVVEa0RjaHpPTzVp?=
 =?utf-8?B?YXhFYWJaM2JUQnFoa0NWUEMxOTUxbVNyeTNJYk9nZFJXdHMwa3g0VFJXWXpu?=
 =?utf-8?B?Lyt1WmpyQUlOU2haZnVwemVsa0g3RGFJOUhoaEFWWHA0UGh6NVM2RTE5ZkZ2?=
 =?utf-8?B?bkpaeDExYllFazJBRzBad3NDQzI1TGVINlhuakdNN3RHYnYvWWlZcjkyMUpq?=
 =?utf-8?B?aFIwVngyeHE3cVhrN0VuYm5JcDd2ZjVhbG1PcjR5c3UzVTMzZ2YzSGw4TFd1?=
 =?utf-8?B?MmJPelg3S0lyYkFETWZjMUhDTFBxdkxDM2ZyeVZsYzMrc3RpNmNZNXpKOG1l?=
 =?utf-8?B?UmxrZkdJMVBTa29lYWhaa3pmM2w3ZUhld0NnOUxPamVvczIvOEEvbDkvU3VV?=
 =?utf-8?B?V2VUZWJYV3NSMkE1RGVFRTh0UnUzYXBDYzhuZWZuUkhRQ1RYUHhjcitncDVH?=
 =?utf-8?B?d0JGcUloL2Q4amN4TzRRQURENzJNRWtsYmlTOW5xOUFOc0NuM20xR3Q5MmlZ?=
 =?utf-8?B?cktJaEJPdGVtQTJCaW1NUDR3bFMrbkx3QUtNbW5COXZVNi9KUHlvZmFNeW00?=
 =?utf-8?B?QmtraUdyYjNtMWpaekpRU1VnOStlZUFPR3ZlZFhFNTU2SmRQZGNXNjRZNnB4?=
 =?utf-8?B?K1hoY3FNNjR2RDFkTjJiL1lFL2srR3NYNDh6d3VkTVphNWIzQisxRmM4MEZ1?=
 =?utf-8?B?QnAzNnRLN1BuOUxpOENEbmRyZXVFVjlxY2JTbEJNTXhWbDZrcUhmb0xNK1JE?=
 =?utf-8?B?cjdXRXhNcmZYamdjTnowYm1qbnpGWUVOckE1QmcyVm9hbS9vSlpVV25sVUhm?=
 =?utf-8?B?YWZCMmVkYkRIbVRMZUtCWXA5bkdFRVJzL1VJRzY4bG5HL29qKzNwRklKZnZw?=
 =?utf-8?B?d0xQZ1N6eUFhOFZpd3M4SFQ5SWt2MW8zQmVwZ1JKNWcrOC9KenJMa0FGYkNV?=
 =?utf-8?B?dGdYSlhMZTBiU3Z3VThhbjZJcm5SU0Z4bFEzdkU3WjZEZ3NuczU3Nmc3Rkta?=
 =?utf-8?B?ek84V3FZSUNWWjJRTFJBUTB4bjlLaGZnWFZjYzhBcm51TDRFdEFvdE8vT0pl?=
 =?utf-8?B?clY4d1pFZXEwT0NqN3NpNWV3M0R3MkRwYmdGa0hNZEE3ZzZmOEtwTzF5Z2po?=
 =?utf-8?B?Q2M2TUl1dnV6NlFTVTRyTGVkRmQ5N2NzUXIzbytxL2R5dVZPN0hrSURTZEFm?=
 =?utf-8?B?ejBKRVQ3SnQzL2k0WHI3c3BqaUJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700013)(376014)(54012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZKmqs/lS9i5mmp4bTzY5e283gB6buGG3CKhw7YU1eVWpboS+uwGWUS+9fCmpSG0TwDN+JfxfheOw74bNttEGO929TZRuiVb9zJLOGcjYxgOm2Ic3L7WMixUxHuXJsf4tcDl8HJmBY69jroK4K9advLeeeng1UthCEKiZYGllSMZ5c3AUe85CUxgLAWODEm665HmQsH60jGiG5HAIMViDMlF1S4/NgaFbHW0Hx/iq/0ZeoP8Wprr29zs+FLZ55iZ5Wp9S+3f049LliJYJYvbx7dpGcaOafxu8gJlyPyJDOslS//wWwS6NRhk2m+M+zm21THcrLpJY9/GYw40tGbSb2VI9tcZm6PEKA2eqZ/HIW5E5oWrmhcMafavRBDrWN9dWYy2xXVCtuhpnZgtWwaGwgIqkL7fFqH7vcKVVgGGCJCcqAsIVhGpnzu0/VDzdsrj1
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 15:50:26.7091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a81461-90ac-43a7-4181-08de72f34398
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8780
X-Proofpoint-ORIG-GUID: 6b9xUetQXuGSPXrx6DNBP9oQX__0gdUl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEzNiBTYWx0ZWRfX2aloI9mr6x3P
 aj8ZxbjugpcBtGDT6WSSuF9XjIKK2x7s502ua2AfXd3VtqwiA7FtAeRz8dwoEf2d9v4dLSOpCZI
 TOMvP87jS2Dn+jQuIR4sBSmCmnVcR8pN4jmdRWf0SaPG4euuG+XUOX8VeLj0t09mqqLmb6TQHRv
 GShG2Tzq01HFpGmv/O2nNtrmpSbGQTYLdf0H1XS4Tp+xe/ZzSgxKEXo9YwNxUfi49s+v6PCmrXU
 h/hRrGeu1sDcRm8cRpVgcEA0Jlm8ZRfvHriP/vmx+SgwQUCJQdSWpD7Lm+yHnv0GE2sMK0oDaFE
 SsqiE9dVGdKnYTzNpBwGO3n3njwVeq837bM8e4uOFWr4zOlyO5rJD2AGVd8T+P38HecR0gEjL0V
 7cPt1w8uxwLMj5ZLAazlc+6Lk1KU9WFGqY5VHu77mmg7kIxhDSYVeidD4HkWsXMTS8dLPK/Rk6P
 /xW6ePAnrwar+WLuzjg==
X-Authority-Analysis: v=2.4 cv=V99wEOni c=1 sm=1 tr=0 ts=699c774b cx=c_pps
 a=gCYXggIpC+w3u2dojYR5Vg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=w1d2syhTAAAA:8 a=_7ZiBY8qa2YVD9SfQ3EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6b9xUetQXuGSPXrx6DNBP9oQX__0gdUl
X-Proofpoint-Spam-Reason: safe

On 15/02/2026 1:55 pm, Khalil wrote:
> To: broonie@kernel.org, hdegoede@kernel.org, ilpo.jarvinen@linux.intel.com
> Cc: rf@opensource.cirrus.com, linux-spi@vger.kernel.org,
>      platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
> 
> Some ACPI platforms (e.g., HP/ASUS laptops with Intel Lunar Lake and
> dual CS35L56 amplifiers) have a broken cs-gpios property in the SPI

The only Asus model we are aware of with CS35L56 and a cs-gpios problem
is the GU605C. That was fixed by a BIOS update so doesn't need a kernel
workaround. Is this the Asus you are referring to? Or is there another?

> controller's _DSD that only declares the first chip select. The second
> chip select GPIO is defined as a GpioIo resource in the peripheral's

Maybe the second. Maybe the first. It depends on the hardware.
Some laptops have four amps and four chip selects.

> ACPI node but is not referenced by the controller.
> 
> This causes the SPI framework to have no GPIO descriptor for CS > 0,
> so the chip select line is never toggled for the second device.
>

It fails before that matters. The driver for that device will never be
probed because SPI core rejects the invalid chip select.

> Fix this by acquiring the chip select GPIO from the ACPI GpioIo resource
> in serial-multi-instantiate and installing it on the controller's
> cs_gpiods array. The GPIO must be set on the controller (not the device)
> because __spi_add_device() unconditionally overwrites spi->cs_gpiod[]
> from ctlr->cs_gpiods[cs].

If you change __spi_add_device() so it doesn't overwrite preset cs_gpiod
you could set it on the device. You wouldn't have to mess around with
the controller configuration after the controller has probed.

Alternatively, if you can make the amp driver probe, it can fix itself
up like the cs35l41_hda driver does. Maybe you can use this
special case in the SPI core:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/spi/spi.c?h=linux-6.19.y#n616

...

> +/*
> + * ACPI GPIO mapping for the chip select GpioIo resource.
> + * Maps "cs-gpios" to the first GpioIo resource in the ACPI _CRS.
> + */
> +static const struct acpi_gpio_params smi_cs_gpio_params = { 0, 0, false };
> +
> +static const struct acpi_gpio_mapping smi_cs_gpio_mapping[] = {
> +	{ "cs-gpios", &smi_cs_gpio_params, 1 },
> +	{ }
> +};
> +
>   #define IRQ_RESOURCE_TYPE	GENMASK(1, 0)
>   #define IRQ_RESOURCE_NONE	0
>   #define IRQ_RESOURCE_GPIO	1
> @@ -114,8 +128,11 @@
>   	struct acpi_device *adev = ACPI_COMPANION(dev);
>   	struct spi_controller *ctlr;
>   	struct spi_device *spi_dev;
> +	struct gpio_desc *cs_gpio = NULL;
>   	char name[50];
>   	int i, ret, count;
> +	bool gpio_mapped = false;
> +	u16 cs;
> 
>   	ret = acpi_spi_count_resources(adev);
>   	if (ret < 0)
> @@ -139,6 +156,72 @@
>   		}
> 
>   		ctlr = spi_dev->controller;
> +		cs = spi_get_chipselect(spi_dev, 0);
> +
> +		if (cs >= ctlr->num_chipselect) {
> +			dev_info(dev, "Increasing num_chipselect from %u to %u for CS%u\n",
> +				 ctlr->num_chipselect, cs + 1, cs);
> +			ctlr->num_chipselect = cs + 1;
> +		}
> +
> +		/*
> +		 * For devices with CS > 0, use GPIO chip select from ACPI
> +		 * GpioIo resource. The GPIO must be set on the controller's
> +		 * cs_gpiods array (not the device's cs_gpiod) because
> +		 * __spi_add_device() overwrites spi->cs_gpiod from
> +		 * ctlr->cs_gpiods[cs]. Also reallocate the array since
> +		 * a broken ACPI cs-gpios property may have undersized it.
> +		 *
> +		 * SPI_CONTROLLER_GPIO_SS ensures the framework calls both
> +		 * the GPIO toggle and controller->set_cs (for clock gate
> +		 * management on Intel LPSS controllers).
> +		 */

Only do this fixup for models where you know what the cs-gpios mappings
should be.

> +		if (cs > 0 && !gpio_mapped) {
> +			ret = devm_acpi_dev_add_driver_gpios(dev, smi_cs_gpio_mapping);
> +			if (ret)
> +				dev_warn(dev, "Failed to add GPIO mapping: %d\n", ret);
> +			else
> +				gpio_mapped = true;
> +		}
> +
> +		if (cs > 0 && gpio_mapped && !cs_gpio) {
> +			cs_gpio = devm_gpiod_get(dev, "cs", GPIOD_OUT_HIGH);
> +			if (IS_ERR(cs_gpio)) {
> +				dev_warn(dev, "Failed to get CS GPIO: %ld\n",
> +					 PTR_ERR(cs_gpio));
> +				cs_gpio = NULL;
> +			} else {
> +				dev_info(dev, "Got CS GPIO for amp CS%u\n", cs);
> +			}
> +		}
> +
> +		if (cs > 0 && cs_gpio) {
> +			/*
> +			 * Set GPIO on the controller's cs_gpiods array so
> +			 * __spi_add_device() will propagate it to the device.
> +			 * Reallocate the array to fit the new num_chipselect.
> +			 */
> +			struct gpio_desc **new_gpiods;
> +
> +			new_gpiods = devm_kcalloc(&ctlr->dev,
> +						  ctlr->num_chipselect,
> +						  sizeof(*new_gpiods),
> +						  GFP_KERNEL);
> +			if (new_gpiods) {
> +				if (ctlr->cs_gpiods)
> +					new_gpiods[0] = ctlr->cs_gpiods[0];
> +				new_gpiods[cs] = cs_gpio;
> +				ctlr->cs_gpiods = new_gpiods;
> +				ctlr->flags |= SPI_CONTROLLER_GPIO_SS;

Messing with the configuration of a probed SPI controller seems risky.


Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419337C93A;
	Mon, 13 Apr 2026 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070980; cv=fail; b=TdrFUxXHbVsc2zX55vZSs2XQjHps7QZiy6y6nYfuBCM8embNulQYXCDhfTq6+M5KbJIkjsQfhZC7AenGzmMv0Etky2TCE+7srFb+SWdpXrmqrTfQGYeTb0bKAQ4pC8K4zMPOeiZYqAebXzxLey60PdIk8Nmkde9ct6om918jiTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070980; c=relaxed/simple;
	bh=Tb5H0EcfioIlMOGMe5I+SzQgyMQ1t3k5ijW+Ou9/Wbw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oEDwQAfrXUrOQkDnjJIVcpi4KPH3gcc+moGisvWBfUI6sr3gBEh/LPkEYI650DVc4b2FACF2nEoce9L4LC7dP6lglOBmTjhFrs74dAgKlPXwWX851DD6Qfit5u8QVxcwX/2o2kvSsL49MyXxFGFZUwzKHyW8p1McfIEPwQA555g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=o6SgY67n; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=mQyX+Jd3; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="o6SgY67n";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="mQyX+Jd3"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D4iqLb3800696;
	Mon, 13 Apr 2026 04:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=h7LBRyc+v1wQnA97ERpH/m2Nh21Lm3GVqTA1ux6ExO0=; b=
	o6SgY67nmwJgsG/z7kYLS2cHwGIb0yOu0XWRu89zC8Aag9umAbgMuX+x+TPvReSw
	xyWDVcYBGiBZ8TZl7GgQsKzzOHtcqQHNO4nO1PUbXN5mSls8dAy5XnJDY850xr9Q
	/CCf084r1t3+yRKlUGFQMHdo16dou38MtwmVD48I7bLhw0hGoFs786j4hqhsu0fj
	xA/MqWxAx0dQwoMopzb5TzMoIs8R56bGCtTpdOyvrh8pgypg87tdEOpWUSzKRWYv
	ZnVVAdoMchsrHRfdQU6xavqcZwEVGGwhXN2q3mt7oKA311cuJTmawZ0Qm3pv7FoC
	uWePbp6EXl/cDpoWlFt10A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021141.outbound.protection.outlook.com [40.93.194.141])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4dfkpw9cyg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 04:02:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B447n1DI9yzfmu+czskXABEnGSdptl8odDiOs9cwh5WdGdJru17NPuA/uv5jd/Fyfmv/2trOqVelQTANnIX/xK4El0q08Svv3yNUlgCnlIbtP4GDRfrWGgRIbuLK4dAWQpne6PxVDVgAieyHULmTkuvgJl2LKMVotVNjmzkZ8aOj/M6cUMX5Ke3FNmXCXSoIE4KF1JNcXUio5dXgY8ZCKFqA/DTbL7mOFWcovJjvZ6zRt+QNVK2M1yVYHMidE8LOMtxlk4CaNHGEZn75eYXeOTJ50gRM4xOlSzTw3IblKOueNCJ2rOK/iv2GR0LY9NG7AlMCIXoUaqJfLwehC/l5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7LBRyc+v1wQnA97ERpH/m2Nh21Lm3GVqTA1ux6ExO0=;
 b=JgyHt8yE2FerngNtQnPPGCqSQnj5Lwx7u7FOrKnITGQjFEYS1tRSIi9tD/zf6OSSW9qst6A74UZdMvBqjdKtE2brokkWJ2Tf5Wtr5fyzAZsvbI03Uw+W26kRXgf53SWTciqYgFMNG7rD3CbrSLXrhTRiyfccECpX/z4XJOkIT08eYbSbGeyjqJYFw0iUxdZomppCwOe2Vfjva3BZWtomG1nFHP2ParnhoKyhcz82vMJIINm33Wh2U34Xqt9bH91UfDQ5/Zi6qz/hd07bDleLOh3Xro7/AB3eow/hcEhLAl2+l9LRYON2q/Xnq6WyrvV5MJwWKjTrrccvRKg4rkfyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7LBRyc+v1wQnA97ERpH/m2Nh21Lm3GVqTA1ux6ExO0=;
 b=mQyX+Jd3lxUnzBP5odLRX8esRpum2ZcVdR4e0L0zUJAYh+s7ECiGhwYXrm5TGEs6NZgeE3UKzUeCmVOJot7WQV8DVsgZK1bFQDHBtqsiJzuI4HrgDqtJLyo7k1iDpcpTIItInGqmHvRRk8XSsHNU76parFYO4S4gsLG/0Dwte40=
Received: from BN9PR03CA0603.namprd03.prod.outlook.com (2603:10b6:408:106::8)
 by PH8PR19MB8151.namprd19.prod.outlook.com (2603:10b6:510:1be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 09:02:36 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::20) by BN9PR03CA0603.outlook.office365.com
 (2603:10b6:408:106::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 09:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Mon, 13 Apr 2026 09:02:35 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C9962406542;
	Mon, 13 Apr 2026 09:02:33 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B351E82024A;
	Mon, 13 Apr 2026 09:02:33 +0000 (UTC)
Message-ID: <1c7fc15a-cf91-4627-bb1c-9a15db307bff@opensource.cirrus.com>
Date: Mon, 13 Apr 2026 10:02:33 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Fix CS35L56 amplifier on Intel LPSS SPI with
 broken ACPI cs-gpios
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: Khalil <khalilst@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: hdegoede@kernel.org, ilpo.jarvinen@linux.intel.com,
        linux-spi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260215135524.1171065-2-khalil@rentman.nl>
 <20260411180414.481427-1-khalil@rentman.nl> <adrD2BrO11tQq49R@sirena.co.uk>
 <328a7f49-3c88-4417-af3d-9530b78dadf7@opensource.cirrus.com>
Content-Language: en-GB
In-Reply-To: <328a7f49-3c88-4417-af3d-9530b78dadf7@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH8PR19MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e4f507-7eca-42cf-7e5b-08de993b67d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|61400799027|376014|82310400026|56012099003|18002099003|16102099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QrxrxIKFQTR6NtJSjg0wo6cgxvfVXhaOlV6tpL6czAKZmU30py4IU/1GDz6gh+5JeRw9ikyi8LIOsTmGYt7sXWGtuqy6A9E4ok8JbeieDZrjVuwTQCcRYslyO0pdlyZG+ATA29wZCm0WBxtLdpXa030RIPlbijGvkffMcB+wnwrQS+fzOo+h1Gf2hJ1i8AZAMYBN9X47VjdLGW+p3gn26VT+MRxOuCLZhsYNF/acGW6Xi7DBJ80CzBgLkyunhz3JRKmQjO0CqMx4ylg15vhVjH7c5mH8bbr3q1TlSB7ltu5/VJ7NvoydKyXwXIQmRrh06sVTwc+rfeHS6ApZF8Pi8Kq58D/IlaTz+wQWpxgeZ8Jqi/6J+wwJ+62rl+WCsJEIYmFZnQRvuCjD2iaRtpyP71/wMaXVPRIkLah8qV8kuLVS5p9zcN73stepS/sKukXXf8rtL/xulnrq3lz/82YJ/T9KPfccWYxr75IRUiRnRFmG0eGHfvhYuoyxHgb18ZFZ24GQKsfyOt0eqJgurYnKswe3gnOf0PNncVd0r+GInulvQq603P7zMjfXz5P2MkGoeXNDqbCuJrhEQAkxFb66pldELPTLbSHpxnzfj6oQ2xCo7arLJLWs+rE4ma1iEX51H94PphQV/lgXUucbQa8SZi0W4NkBnQuUpV2kj6BabpSyCX31SQ0vpzITh5d+oud+Wybp85dzHj6EJHp49HV8C1p9OU9k3YE2yKlxCFPWrQtGX9CG/PXS2zIenWr5osrYqHcGxrTEMRtV9mATRrGruw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(61400799027)(376014)(82310400026)(56012099003)(18002099003)(16102099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bhVux3ckOkcvDx2joUgAM+uTy/DnZaGtSjc9lBJoRX2sT0Ow2wsISk9BtmF4LQE5S6wMWFlA+E6pYRIqurxJTfeZHghFcTQRc5dHkSvmFNR7py6/mOK9YqwIx0B+ks/gcNo3dybZlxPucydgvaSfH42izuPY7UrnObU4MiOH6gx7HnGv85hrSuuXLnIAM1U5jJd+XoShL8tYn8lwfVbgvVh2vGQiqzq0x/AymJlEw5jx6xhW8G5xMg8ZAutzX9OXyjz36Re+XdAKu8QoDqXdSYBgBtICTUJyMPKQGABzd8vi7AqdG37n7FLPLdlzLrPBSGcVYnX+X7GFvd2hAjuJuQxiX0A3YWLIfdFHLHi0mmkIMafWXxi/GdGeFNjWc16p2hGHOK9lcFV3MmNoZm8bnzfasb41ZGjhgOGguZpfPzprgDEjg+2i8TO0KM7Bny/G
X-Exchange-RoutingPolicyChecked:
	egnywwPsxJ6nImonm8SULoH/lEhzHgG8VAucasbd8aZQNk7WKXUzrKpGfuhCRset8fboIQcCTDf1n3KxAVrpD8kMQir9/Zv11/g1PDIu+FwKPlOVEbUeKB4TtvscP6Ckkukx7/J4piC634MUSUFXPurvWbGzhdLCP4bnrxNu10nZUEjOX9VRpHOWTPQYA+QDFOYbzZaB7wdK0oX7e/Oy8UjTp+L3aRG9fhYBnmhzjHOSj5fC/pzUzQTLzqpNvbK/NsuMcCYkQJ7hrG0vZW/rKg5u2bqZe66loEhmitbBtALJusOSil/HYkz0kPFEfCNg8N/sw5epSjpPi1kuH/JXWw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 09:02:35.4964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e4f507-7eca-42cf-7e5b-08de993b67d2
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB8151
X-Proofpoint-ORIG-GUID: bCYqteXZevEfs73ldt4jSoUfmmY-MuaW
X-Authority-Analysis: v=2.4 cv=a7EAM0SF c=1 sm=1 tr=0 ts=69dcb130 cx=c_pps
 a=OpSXQbuC3dJaDDyxjzMkQg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=0zuFZeP0QowzwnVspswA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4OCBTYWx0ZWRfX01HD5uwPybdH
 BpUB2jm1AlclesGwJ1THAZfbG9eJkmyoaY3P0TG/uWmjBytUR0WE4Gyr2cubrx4FOemAX0Zvh0j
 BZr0x7rnFP3dESdZ+Oz7Rn74BRCK9TqQoVNaK5IZ2xnFncGPR7K7BMNSH+Bc9HcDw3TltPWl1R8
 p2e+zoYiAEJmlD5Tk3GjHrXKTJTSzZUHPYIHJZpy1cxwu/HiaKvJC+B+SYTbTit73jyfeni2BCk
 yq/WewS7fhIuUBO2Jes3d3kAdjWsMdNBzNqRDEs5cY5fARWHWKhHrYmSh85HBC4neBW84pP3NA2
 NOfcjPzjoMCYKTGcnCmhNYozGjhj+GMjPXWTzpIUkLaWOe5p4ZB/tNaWN4MhQ762+q/hc6I5Fe8
 CQC2IcTIJ+BQHzpXJCG0oyKRM8HheF0qU9lMArZwhhuXM/a72b2vVikIwuLtzasWuWCByj9TNpz
 bL2SEsbdrabokMt1mvQ==
X-Proofpoint-GUID: bCYqteXZevEfs73ldt4jSoUfmmY-MuaW
X-Proofpoint-Spam-Reason: safe

On 13/04/2026 9:48 am, Richard Fitzgerald wrote:
> On 11/04/2026 10:57 pm, Mark Brown wrote:
>> On Sat, Apr 11, 2026 at 08:04:11PM +0200, Khalil wrote:
>>
>>> This is v2 of the patch series fixing dual CS35L56 amplifiers on HP
>>> laptops with Intel Lunar Lake and broken ACPI cs-gpios.
>>
>> I can't work out what these apply against, please submit against my
>> current tree.
> 
> Also please put V2 (or whatever version) on all patches in the series,
> not just the cover letter.

... and use ./scripts/get_maintainer.pl to get the emails of the
maintainers and reviewers.

The email for Hans de Goede is <hansg@kernel.org>

Can you also cc patches@opensource.cirrus.com. Thanks.



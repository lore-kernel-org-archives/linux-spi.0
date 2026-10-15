Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967794D7D21;
	Thu, 15 Oct 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073070; cv=fail; b=j4O/5CyibPl4oMJaS2i6MBUtIiferFtX3aGLBfMumUvMQijRIdpArPdxq4yLfFR2rXwhKkbWU1eJNMUr+wChp2jUX36WU6yqAATqemsPashdY+2X40qQDqM7a26AUwDXAKsI1wOU6hBVnykqbHtQGyNH5lxOpdwo3TxwX5HFFNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073070; c=relaxed/simple;
	bh=j/ww5MqWBI8VGwCaJN48wGw0ofr+mRSpBzzcH8oJAZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ROxGy+rQ3GxJwfZjLvDd7CAVIN5IdL3UnS9F7biN0/lkydSHT9Ukv1gQ4XzltJToZX4SXNraXwwkocXAEOy1oBrR9qMy5A1AB+jNX5UGS2CKcy2oVAhXtBcrSkFI78XvG0GHY8JM1OBWkIhx+Oyyxb3CVoOqYFI23bq3RZt2urw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=g20ITxSD; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YU36KsPu; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="g20ITxSD";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YU36KsPu"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FDTewL2503960;
	Thu, 15 Oct 2026 10:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=O26x8m5iXykmrpHH3cptzjY8FspmgzZy9vglE88U1Tk=; b=g20ITxS
	DSrXL9V0C6a38HgVnefKkFhv0WR0WOtkq0UCEXv2D74XhjeTjagNEFWojOVYF9Hv
	k4Zd0cbO8UVfiKwgfPKRAnPRHov6FZtCR/8aiTssUHGbGPMiuwrz0ZlRieTr51eA
	PhcOA3iaoFtWdcJ20QBm20coocXJ/CEv+bzTZUBbUqVdLJrZ0UIEmdU9AdcGNx3U
	/mlHkMfphVtCq6++z1TJdLDij9TseCS8aCba+1V1Q55NEO+2yMVcyo6YYB4gFys0
	iZgB1gqKVpxxaSCPHdHSNpIN1FvdieniaSuGdLagIVXLMeXrWo9cAl5AtgAkMBRX
	T/DBH2pz7XcwFxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=O26x8
	m5iXykmrpHH3cptzjY8FspmgzZy9vglE88U1Tk=; b=YU36KsPu97vwB9A03cEo3
	TGVg6GpgR/Fx/eOmETnX+s213pDbobCtujATyxfG5xDHGwPFOqwyqsBH4nE5goBc
	YLleqQTkR8Y5PzNA3iZAbgijUOP8tcaUAWU1S0MkydnMcmR45VbDeA7Sc6HmNX/e
	PefXlsqgUuqrJa9ACZJbfo2z1N38JiKMfG31Bi953VahcsHAMjUJyS1XdTr6zYGE
	7qn3zGFdj27yWIOn/B1wgFW6x17Uv6KkhuvjVXElj3GcSo29F2L8uExvfgSQGpQF
	1XvbeQ2ltthjA6vOIX6vYrabU7muDra+nVNYM31I2IeUgHEkZccuI8HQo8GPxs2K
	w==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4harn92hkb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 10:04:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXptsYuqHua47BzDPgScUzWwTgS3cvn+u7BMRJLBY8r6lsAM9kqGw8ivhE7ztMK0h7MfdIRIuG/f3HA2olDDHq/wTCvDz4KgHcMhvCyBSmEm9iCyuWKfIxMa+PRs0lhLiK7NRJ3+LdCJLC0rf9pSCHXchyN14vPLumSuyXONPc3qreihkWJ8eulxizLDvxTtDeB9Uii2Xr1FJ60oFoq/uH+FEx0ysS3UTgdMCTtML4a3oqclniu5NLYCQSrnIEf/dPBy1oEPtWIRNfct8Y4SOu+jKXgQqKs1xgOtjptnhtT+m0j0FD8Tk5W3tjx0Y8bJ0QWKgGH6LX0X6ZbARTuASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O26x8m5iXykmrpHH3cptzjY8FspmgzZy9vglE88U1Tk=;
 b=emtmL882KxtRnK6TaxvgNsE+ZdcORbSTFFe79eUlsHHZ43xNrEBmlSPs2TYupzKzn/OIvNFNDL3nZOs/XaohAZkqdsgw6ieHIfB7a2DkqHixVb47EuU+ft1LDPbYffkLXW5hHBdQoKCFmY/NFQe6qxzRsY7sxf+TJIjU0IRYQvGK/knj1IiWVZIkaN3es6VMU8KsMM3CdzFjf5cMUMYLB5o3NfS00p/7aXbwcvqUnBkast+XG5+//QrcNkzTP9CaYuXRuJF/f6r3k+H9geqKwAJizn/H2cIrMyKbzXCAzS/tza/Mp2ALl9IbC1tE01K/cMmnCaSj6JNDOc4Jd/iMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by BY5PR03MB5064.namprd03.prod.outlook.com (2603:10b6:a03:1e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 14:04:07 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%3]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:04:07 +0000
Date: Thu, 15 Oct 2026 15:05:27 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Carlos Jones <carlosjr.jones@analog.com>
Cc: Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: tegra114: assert CS GPIO for every transfer in a
 message
Message-ID: <atDcNLd4U9As8Lg8@nsa>
References: <20261002085540.1625-1-carlosjr.jones@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002085540.1625-1-carlosjr.jones@analog.com>
X-ClientProxiedBy: ZR2P278CA0026.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::9) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR03MB5458:EE_|BY5PR03MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: a200929d-b510-4071-5c59-08df2ac52d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|261009220027099003|261009221727099003|261009221227099003|261009223027099003|261009223327099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Wn83dye/aslXuvMaeU9aXKXMH6W0cxoHaxDVm7Iw7mHz8eqJ7GTpFLmS1XcGzg9ZebH+dHusEhefMPb40MtrqKb9QBNy6YH4HJQfFjYpL3vGnE0N+axjatlXsS2Jy/oM2qt+fIfAlR197CWtHoGj1F+2Z5AEjVAreChIKypN0GSRIG48ZUPZP/M/uciliQ5CbL5/2hUxCjqsAGiNPQpcp1tbPbmA0I6pHmS9gngmhSqZ8+5OzUdbS7TTNO39yyyM64BMMxOakHTRNfB7pLaHnXevUk5bLxCjVlIk5rD7bVngZqxAeQkiJyoofe39on4XdizJCAf86Wen9k197F99FNRKnfa4JBwQOQR0X2uCDrx8KLPcQpxVqKwjA3mx0rXyJkY3IdH5Ewnj4z5gv+ZxTRZFUOOZ1r19LUfitIMP48XzTCust6ygSo5zeUZcYXxZhuaknNEUpWwO8YyR2I2Qi68Msd8I5tAiNeF4KegTUpSklCK8oQdzDwPttG6cpWwXR088ytlG6klD+EKxZLZfDPNwOZrUwVhJpFyNnCMB5qk6M7F/TtsUOVWnejU/P31ajZ+21mZPzn6WaAIq8ucYzkFB2b3r9yyttlyQ08Kc67nucPxEoLKZSAb59zPp03HF9xi5PzVJJNd40Oeu1/7jJakc76WfyTo35O1Vc8ylIAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5458.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(261009220027099003)(261009221727099003)(261009221227099003)(261009223027099003)(261009223327099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlBqbGJiSkFPS0xEWHc4YzNUdk9lRHBxa3lBMTRUUTFPdVlLREFXYVlOUDVa?=
 =?utf-8?B?R25mcjBHdnNjZ09ic1paZDhKS1hlRnBBVjFFaG9oU3RZWUxRckM5aFZUbnFZ?=
 =?utf-8?B?NXFlSFZVa2tMUFh2YSsyTU1UbEM1N1BjaGpvZm5sMkJYNHhYZ2JWZklGcTlI?=
 =?utf-8?B?Ry9PZUM0azl0Q1lTa3cxYStsVTREcTMwMDBxTE51TEJubExWNU5TUUZwa25U?=
 =?utf-8?B?N1RZWlVpYW9zejVHbENqMGh5dEZGMS81REhMeUlpOUcyUjFkSkJyU1EzbnVJ?=
 =?utf-8?B?T0hBMks1d0x0Yk9lL2IxZURRNVVPbHZKY0FKNnJVRXFpZzZlMjN1MjVvZjJt?=
 =?utf-8?B?TTNjK0k5SXU5TGxJak9vWnY0M3AxYkU5RDN0KzJtOVBScTJyL1JiUEhNY1dS?=
 =?utf-8?B?c3hnMzhtdFJOV2FSaWhYQVdYVThyQXQxZEZ2U2JVRkw2VTRJa05Tck9Dcjhj?=
 =?utf-8?B?L0Z4aEdPeXo5UnNOdGxVeFVDVGtBNFVNMUZjY1RMSVFIeElMVU5BZ0lCbTR3?=
 =?utf-8?B?QTBkZFVERnRlZU5XVnd6YWRPQnpReHJYNWtyT2tGdnZCb1FTakRXVFN5ZFRC?=
 =?utf-8?B?ZnMyU1ZlaW14eGlKZ3c3MGwzUkRKUWtJclg0L1lBZU9ob0V1Z09ENEZjOUgr?=
 =?utf-8?B?MjBodXFiTXZMS3prUk1MaWNqNDFzQ2ZNOEU4Vm1paGQwQTRGWGNHR1NDdEFE?=
 =?utf-8?B?N3o3emxNWkF2ejg2UHZGdUt6S0JXazB0ekR0RndFQ2ZxSkFFd05jMUdjdVNV?=
 =?utf-8?B?U0VMNTVJR0xOaGZRQlptMXByTjZCMFBtS20xcWE0dU4zUTRwdnRMdUkydkR4?=
 =?utf-8?B?cHJjcHV3aHkycWV1QkRhcis1ZHVZdGJtQWNCRjhVVzVkTVFObXBaalQxaHFo?=
 =?utf-8?B?MFVpa2orM0FuV1VqcE12Y0Z3cUpNMWsyL0tCMnUzTk51QUZ1TnBqMC90cmZ5?=
 =?utf-8?B?c1RmRkFSa0R1VVJsd3FiSjc5b01yQzJRZk00L0tYd0FkUE5ObXExekl6VmpG?=
 =?utf-8?B?cys0TnVzYjVzeDhic2cycmFUSTJDdU9VT3NUK2JObGdFYzVXUmErSjYzbUN3?=
 =?utf-8?B?MkQrMytQQjdjN0lWUFluT3JmWmxmTGJKbHdnazhMWDBBWU12YncyVkZqKzdh?=
 =?utf-8?B?bjZsdDhGZkxpY00rN0UzeVZJbVd4SEdlWldpbVVHQnIxRWF2RFlPSDM3c2tx?=
 =?utf-8?B?b0FBazJaREZpei9hTXRpYVA2aG5JSDd5YkVlTW9zZ1FvWk5nb3lZbGhmR1Fk?=
 =?utf-8?B?eTBkL2tMT2hsZGpiL21UVWRDQUdYQ1pjWjZjb0Roc25BOGtZT1hEZW0wdFJ6?=
 =?utf-8?B?SEVuR09GSFN5emF6YWVMcThSSGJuVGprSTI4ZjBDUWZLa1RtRDFhRXh0SjI5?=
 =?utf-8?B?WUM0cEdndjRGMjJZYmdGTE5XbERlbTc5cHRZT2xaSHRSNmRCbUxRRndDZmhJ?=
 =?utf-8?B?cE1zOXB3WnMwak03NzZuU01KNzJMYWo0aG5jWkRzb3RKSXFnd3VhWmhaMFBz?=
 =?utf-8?B?eWNLTXFNbVNVTk53V1NFdzZ4YWhDNHc1YXRDeHZ2MDdJakg5UHhUSDZYSHRy?=
 =?utf-8?B?UU5yMmpGN09EaC9Ycm9vcmNGaUFkNUJ0Yi9wZXRyVmhOSW1oaGI2N0QvNmlO?=
 =?utf-8?B?YXJYY2N4aUxxUnE3V0lYWldtMVo4Ly9RWlVEQWhORTdnNVZQTHhIcnFKT21O?=
 =?utf-8?B?cVN1ZDdWYnlZdHBvTEpsLzEwejhkdGdiZjFJMW5jcWhyYUE4N3pZcTE4Nllx?=
 =?utf-8?B?UlZiQ3pRMU9GdzNrVG85c0JqYjVIdTRmUmQwMkdnQS9pdlp4TU5JZ0hUai8w?=
 =?utf-8?B?aVQrU21FUVh3S2toUU5Sdkt6VE44ZHA5ZFhMRm9HdE1abEpkQjlEaUZ1ZTdx?=
 =?utf-8?B?QkpTSVA4SlpqU3RqbmVESlIzQ29Zb0tGaHorVmRjdXVEZ0xndVZ5UFRLZCtl?=
 =?utf-8?B?R3MyS1o2Z1hwK2VRQkc3NFFVQThxYlg3ZnBNZFdaeUFQMytnKzQrUGFWSFBX?=
 =?utf-8?B?UURya3c1TU9YcjlqbmFIcXV1djdidzFlWk1tT1YySUNtelVBbW5FL2FHQ2kw?=
 =?utf-8?B?T0FsbjF6WEJYaWs5a0h2cDRSd25CZHNFOXFuMWhyWVpBSkpmaTFqM0RvZTg1?=
 =?utf-8?B?dHdGSmc2SEpnZ1E5RDlWN0dNWFpPZHI5SWF2bnlObmJsajBlYUN3b2ZlQ01r?=
 =?utf-8?B?NmgwVTRvb3RjdDd2Q01aR3NMSkUycUJRTUxPMEttUGNVUnZXNU9wWnQ0NmNp?=
 =?utf-8?B?NS9oWjlPRXVZZ3hsQjZ4Sm1TR0dJTHFJckkvRkRJT3QrSWY1SEFjRFBscTQ4?=
 =?utf-8?B?eEVCQ1A2cGF5STFKZTlPZnVlSzZheHJJQjdIeDVSM3U4ZE5sYkZ5Zz09?=
X-Exchange-RoutingPolicyChecked:
	fML/HGOGYTXDwlQNQ6kq9gcib5h3dxScmy5y5L73+3Hjp/EVmtpLGKBfEmcwU0HqS9qZSzxnAdyQCw6OHAO+uEkzw4eJSSHR7yRWpLgKP+DfX3pJp8rC5w2YYhibbjbfublOxKJgee5LbIr015HbxmsMoReunu3lN1tOxYdNIANK3Drc69kHgCh7EbJOiTno0XKBzdmBy6+5klURrT6z1b05HXUdGPoA3JoC3G6l6/k2Xw71cktAnb/VOoAZHTL5HWotFHdGKtqhcTeoQ5Jt14dUgV1Y0FW1aOeBa0cveHmTaz1gdQs6vuqeMgYZbm/eZWSKQj1EKkAGJKHDcMGljQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a200929d-b510-4071-5c59-08df2ac52d08
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:04:07.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqzg+En5/nt6GZo1xjKW61Oq/vMVyQANM4f6PXSII/BmiI+iBbEAfChFgYemioegwH4mKBMxEBXnidJ1Gu7OEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5064
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1NSBTYWx0ZWRfX4OJIa2YR7y2h
 PAzFqgnt94YqtQIcjgG3/hK0wD/31VPcENy00baD3JZjKbPp5m+QK28ZyV+LaZ6BtYQwQLjtWMo
 8/4iHuT/yrcaVsOvAn+miZ8j1TUQFSXvUvyAEJyzC1MdmXGul9x6NCosqTIKAze3GEtgBPNpDqY
 16qEg6xwTeDpU4bjXg8arIgMRHoJS0n1nccwvNE1Ux604+Y/PVUbeAL9e16ss2uuxsNbPiF4DTo
 gVw6esMCDiEMUfchOqF7O6k1xfgtAao4Shlkeq63nuisHO/OchUwQC6+BTVaahY3q6hatveKYl6
 kxLmwQsmHeOdMz1BhpqnpcZvS1n9XogpzjQuia8AeZ/GrfIrZEL9cXfNpmgaV8UhR2WOoC97Jsb
 /jmZfuKIQ66lI1VAkycvomKgqmg3DFyxHulXfPyG768UHPctkkSNK6utP75X1jXs/a9jZRCho8m
 yaNLVTh7VV2UZhnbTYw==
X-Authority-Analysis: v=2.4 cv=eOmGH3p1 c=1 sm=1 tr=0 ts=6ad0dd66 cx=c_pps
 a=E1AkXC+xFF28g4y6WI75Xg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=gAnH3GRIAAAA:8 a=756wpPC6nfCNrGp-qx4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: hP0PzgIswY5cMDAwWf6pZdeTS2_zJE_g
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1NSBTYWx0ZWRfXwwVvTFkcJKPQ
 uREly4nyBAscD9rss2ke1FEFtFnczzfmxJZqi6krHIfaJ71lipUFMuntYNaINdYFkN7JvSu7y2T
 hViHhpeqJugs3ZxMyGw2iBgi+9LH8jSJRZ4EmEYAFg+wvYn0/TXn
X-Proofpoint-ORIG-GUID: hP0PzgIswY5cMDAwWf6pZdeTS2_zJE_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150055

On Fri, Oct 02, 2026 at 04:55:40PM +0800, Carlos Jones wrote:
> From: Carlos Jones Jr <carlosjr.jones@analog.com>
> 
> The driver provides its own transfer_one_message() and therefore drives
> the chip-select GPIO itself rather than through the SPI core. The GPIO is
> asserted only in the is_first_of_msg path of
> tegra_spi_setup_transfer_one(), but tegra_spi_transfer_end() deasserts it
> whenever a transfer has cs_change set. For a multi-transfer message whose
> earlier transfers request cs_change -- for example a register read that
> sends the address in one transfer and clocks the data back in the next --
> the CS GPIO is released after the first transfer and never re-asserted,
> so the remaining transfers are clocked with chip-select inactive and the
> peripheral never drives the bus.
> 
> This was observed with an ADIS16470 IMU (adis16475 driver), whose
> register read is a two-transfer, cs_change-framed exchange: a logic
> analyzer showed the data frame clocked with CS high, and the driver read
> 0 while the device drove 0x4056 on the wire.
> 
> Re-assert the CS GPIO for every transfer so that multi-transfer messages
> keep chip-select active across the whole message. gpiod_set_value() is
> idempotent and polarity-aware, so this is a no-op for the first transfer
> and for messages that keep CS asserted throughout.
> 
> Fixes: 63c1440596ff ("spi: tegra114: add support for gpio based CS")
> Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
> ---
>  drivers/spi/spi-tegra114.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index 1234567..89abcde 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -859,6 +859,13 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
>  		command1 |= SPI_BIT_LENGTH(bits_per_word - 1);
>  	}
> 
> +	/*
> +	 * Re-assert the CS GPIO for every transfer: transfer_end() drops it
> +	 * on cs_change, and the assert above only covers is_first_of_msg.
> +	 */
> +	if (spi_get_csgpiod(spi, 0))
> +		gpiod_set_value(spi_get_csgpiod(spi, 0), 1);
> +

Makes not much sense to me do do this on top of the `if (is_first_of_msg)`
path. I would remove it. Or just set the gpio (if no hw constrain for
it) right after:

tegra_spi_transfer_end(spi);
spi_transfer_delay_exec(xfer);

in the `else if (xfer->cs_change)`. We know it's not the last xfer.
Would be nice to avoid useless calls to gpiolib.

- Nuno Sá

>  	return command1;
>  }
> 
> --
> 2.43.0

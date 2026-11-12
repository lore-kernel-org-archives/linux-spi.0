Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794464680;
	b=s674RfNrf3sp+Xq1fX3Du6qlM2RwZO/ZI8jV7+f3p2ANGsS8yeyZL28PMP51bJ0h7luJ
	 yAUt9RySk02oYC7jZjI7dvFIe9sYyQFwAH4pDd6Mc0n5Z8dHc161QHueXQe6thgfWQMFQ
	 eKv+YARWsbikWpepGCZ5s7H5kaaITrlflpsSN5iOloeSMCfh58DumI5tpm8nD2fl5Wi4n
	 NsMCIYe2U13QUSxg1jQNbdkXIXhMBZAl1GmADHLuPE1pJrhbvBNw6Ip/+penDr4UD29dR
	 VWmT7Yor2NCvBtryw9nMkj8TaH0DfgF8oHPcn5i+f9RyUo0sq+SN8rD6319X3QlxeKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464680;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SharedMailbox-RoutingAgent-Processed:
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
	bh=5UuI6LjTsqWQ873ohFICTa2mWw+5Cn5cuzzxV7FoFpE=;
	b=FB8pQSi/NuOgIv+RK8bMSXgljUm4t4QRhn3w9RcglFR1S3gkbMRdJlyKnvLNEDGt2O/Y
	 9yfRKlSa0izvMDGJS1yYgstD/hvwQapdU9i+Wq5UXBx4Wt7UP02gei69jMLzQHd4bnK5D
	 PJ5Bw2PSM3Qhrz411Bo30ISl7egzo5BVMpapr5r+s3ZebslJzMSHVa8BKmYYOvZKbNyuE
	 zAp+SHIsHTq0YNb1IQTaahSyGI9/xkpjTaEodyKkzfeovKLd0v7I12YrsaDdrAI/dbTlt
	 7vrtyHQ+dVM+NuJbYC9N+UNaFtGN22+rWm+vNgkvYh7TBuU94I5XlPVr5JnWhysQivg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="k/NXUjlY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.12
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E98606A323;
	Thu, 12 Nov 2026 06:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4E98606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=k/NXUjlY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHLjZvhzw5mmO1LPhy72lcOoLuD+mVZYHEJGFqmDVU56qZhAgZY+LmpxOku5ZyPkqyUpvoxLzCCvZWH/3CjGj/74aV+qC5qwtfhSdB29py46hmsYGW7oW5ZDMYnvIL+NyUJh2gVaMTvpPdsLzEcawg2zgeHxlNfh/Sl659AHkBBkuML7Iv8KhJVatbWA6HVC5wunkCXnHuY2nCa8Quis4lwmnbOPGaKYGqS/e70Al3Lsf/o9kRTYuqQcNpWt/mMpvCPpln16UvjzMNmgn8bcBAX3eHH8xViBoNQVYzmsSBzWQPs9UXnr33/05HEDgCkog+m/OcPfpNLGgwx5W6q9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UuI6LjTsqWQ873ohFICTa2mWw+5Cn5cuzzxV7FoFpE=;
 b=GYf93pU0XbU//wgtXSfU+Qcq8DzYlzLA/TnIunUcI5FyvkhCkdNp5Yhu+wgqvcQ8xh/aaqhBCmJTskLht7fpxpYjbaXNl4Jyd2kKbcqi6vhxlFy29FCwwctU9dQ89rp0ojPcdPN+tN3kE9VVCY3Jv6fFIqWZp6il2emtfTF8/h9/clUtAvmt9Vkg9cjAes1lE8wqSqgTvUEN8ICNRlOEUEdv2YkmOfbmbWLrdAXBvotfVv5wjVWp9p43EDbXncs+8qUE8PIeaH34QjAkx4ZMhh8psJ6k4uuGniBo47cXMBIOW/R8r1A1lIupqsfh3R9F/ivCZUkF57r2iCVwVAD5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UuI6LjTsqWQ873ohFICTa2mWw+5Cn5cuzzxV7FoFpE=;
 b=k/NXUjlYjxKQ4YrB9oguxV6R9w0XHSAsF67HiNc0LqMzNbqXjH1rgz1x2YdlQh/vdDGF1CtRL4RwhiAYb4AuGyKHL1/NRgLe6oLeQU3fXbZKiMZJwK+1p9k5Xhx7nTyFtQOXLTPF5N5WghCbsn4duYFarIr2UZBaZzJCfyYki8YmHEizGHtA8PiDNXHo9rqgUSBlf8Y/766TdmMu+OYIsE/XIBOoboeQMms3DlrcrW0E14We4t+s5hzArChtzvPs+kGC64s1FJkclg3KiM03sHSlf8Wovswl1EadfgWEpOrk5pm+9UGKYIuN+GZrzl4ykRNUCKCiMmQoDixiBe0Jfw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by AM0PR04MB12098.eurprd04.prod.outlook.com (2603:10a6:20b:743::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 12 Nov
 2026 06:24:37 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0592.012; Thu, 12 Nov 2026
 06:24:37 +0000
Message-ID: <d7745359-8c73-4ac3-a8e6-175ef80fdf4e@oss.nxp.com>
Date: Thu, 12 Nov 2026 08:28:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] spi: nxp-xspi: use dmaengine_get_copy_align() API
To: Frank.Li@oss.nxp.com, Han Xu <han.xu@nxp.com>,
 Haibo Chen <haibo.chen@nxp.com>, Mark Brown <broonie@kernel.org>,
 "open list:NXP XSPI DRIVER" <linux-spi@vger.kernel.org>,
 "open list:NXP XSPI DRIVER" <imx@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>
References: <20261111202741.3866239-1-Frank.Li@oss.nxp.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20261111202741.3866239-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::11) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|AM0PR04MB12098:EE_
X-MS-Office365-Filtering-Correlation-Id: f9326936-bd61-420e-b311-08df4085a003
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|366016|1800799024|22082099003|18002099003|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	SMVch5Q5vITVTvcfgi5Zmd4SvCLXG+rZx/jZItR+MBMsDKHHDBlx8+vdnl0DCwqzbUd6zP6H/oBcwxZu62OqhTYuHc9c3otEf7faC9r5g+P1TPSzHYZr1PhrV3vTpn9nfJd3oqlWhiREH1ZqfjNL2wDtCEChLxMZRFUeiap635wsSgvCb5xbf4jPtYP2Pqp5JdZPO6nO3MLLmoWDxGKXCiBvEdSTcjv/Og4T0IWrU1l/ILbn3DveQT3oQmemThjOAVJSuLFqwpdfAHvYzqtaZC8G1f13hFIy3ImskaumIyY75Mr4Asq55XPdIxm/yaBK4HeGnzTXuaQH1x5C9zu5yA1c0l8hpGHeMIfLi3sOR9NZhzm4QuhCIgh1n3tdL6b23rnMRhrAp2uGz14bJly1F4gSyJcF8lKK2XKHmM+aIiCZbTaijpVOsjNVgUF8t1HXOVzq2jlX8dtqabKd43vL1gGKbQIz3inWorkrtkrUrUM19bIzK+G+KbYPBRsF6fmxZOxztMis7ZdEFpQDI0mRxEtJYc1w0LyiMZfpRs7igbT5AWYu7qoqvNacxPqov9D6ayn7pWVRNeaXn1/4p+3Z7QzfV2+nddRweROcHmpsNFWoZVPtMj4hNvSNQhtTj0rrVryEYJ9pwtp3yLtAsNSuqCQZ+d+JHdm7rDljZfFsmsY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261009223027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHRWOFBjcVZBcEo5WGVBcmFPNFlkY2dNUnBja2pTaWdENXVpYXBRU3ZYcmRL?=
 =?utf-8?B?cTlyOXdzRGF3ckZzem1zZ0NwZGdBTjRBYXdBSWtBMmZ0L0UwUGlEQlBBLzlI?=
 =?utf-8?B?a0d0d002bGhVMXh0Q2RqazE3dDg3TDVvTjJFaDJBdnJuOXZ1M2JTQlpnVFd5?=
 =?utf-8?B?ZGc5R0U0NXl5SUJCc21BcmFvVWZlTDVZWWIveWxkV29RTmtmcjNBUlFScngw?=
 =?utf-8?B?a2VWcHpjaGVUZnVTZ3JvN1cyNmFzWVFURng2dmZZNGJXNUE4d1BqMyttQkQr?=
 =?utf-8?B?TlA2QUw4K2tnc2ZmN2RuWHk2YmVJeEYvY2dOejU3UlpVZDU0OVFyUm9RZ25F?=
 =?utf-8?B?RTI5SzlIVFErZ1k2dVJhMTFmdWdDeEpnNVluN1FJUWhhUHN5TDlycGRRTXdI?=
 =?utf-8?B?QWxBRGxmYmwzbm9LdFRLNHAyZUpwUGppTlVXYmlUSUxGaGhLYnFPWDFlVUha?=
 =?utf-8?B?R0RLbXFlS1RrakpBZGR5UFk5eHNjOUZYYVRaMUdVUzhBcXRSR0J0aEZlTndU?=
 =?utf-8?B?eFp2MWhxSHN2ZlVTNE9EaGwrSS9aTFExYkZNK2F0aUZtQmUrVERLUlN4NDZZ?=
 =?utf-8?B?YkJleVpRRnE4dGhEZ3RmMGFnWXpXV2NzblNGcVBTM2xyWUJuNlQ2aVlxbmRV?=
 =?utf-8?B?TURmUFErKzVRRlFLV0xBYUlzeStpRWt5RVI1ZnZqb0xXeE1lNG44Y2pNUjRr?=
 =?utf-8?B?b0E5S1MxZFRGLzc4dHJpZGprV0hqVmhCbUpzVzFNRVVyWlJtb3kvS0pHeUlr?=
 =?utf-8?B?VWhicDVFTGgzcVNhb08yOWZmZGIxcjgyaGRRWExFamRJYlpoM1JyUDFvZ0VF?=
 =?utf-8?B?czZVcVhKcCtVUjVoV3JHYUhseHpiWnhHQVY4MUJtbXhadzlTS0p3ZjM3MjB2?=
 =?utf-8?B?T2JjVnhianRFMUJSeXRyM3Npb0FXVmFxYjNPR3BTZW9XVnBuczExQ2Z1QWhN?=
 =?utf-8?B?cGN0RnFheXNPa1RySXd6TDhMMGZOWEtkZUlnbnFmL0hSRUFJSVNtbnNvSU1U?=
 =?utf-8?B?clFnSFZlemtzeUhnR1hTK1R0blBRcjY4eGNIN3hNOVBzbVZMZU42UUd1QlM1?=
 =?utf-8?B?T0tYNWM2c1RVTEtrdXhYZmpJNEZHWkpMU2JEWDJnL0JzMDdSMWduRXJaZVVm?=
 =?utf-8?B?MW1naGdDSGNmQndjSEFzUENPRkhQTE1iTWlJUkl5ZGNwWkttM3RQUmRnTS80?=
 =?utf-8?B?U09HMERqelJRS0llQ3dYSlNSaS8yRDlOQUtETzdPM0F0SW1tNVhITnZpZmNy?=
 =?utf-8?B?bkN1eGdaR0JFRGRMdG9DTHBsdjFJanlMbENNemYyWEFuYVRQQ2FUYk4ybkxi?=
 =?utf-8?B?c1hqNXdNYTd3aExITWlyck5GdWRTY3FoUUpRQkRDb0x2ZHFJUHlIR1VGWTJ2?=
 =?utf-8?B?NHM3Vkpwc3ZqU1d1TDdBVUkvVUYyUW81cFJpMGNGZkRpUlh3NWFxUy9senJi?=
 =?utf-8?B?VlNMQnkvNHlUNnNPbjJwU1JYZE1rNU1qMkNaeXZ0cytFbGxHTk51dVgxVFhC?=
 =?utf-8?B?M0gzVGVpQlB1N0tBOElweHd6VlNhcUpFYjVMV2dscjBIUTBzMTM1Mm5abitO?=
 =?utf-8?B?WHNRUDdNc2lNdW9iKzUyWFFseFJMdDRpZTArSDNGbzcwVDVxWitTRmwvWThQ?=
 =?utf-8?B?eXRybWdsVTBHZHcydCtzNndNWXYxeXhHRGhrV2VDVWlxY2dsUU9FSGRDbzZx?=
 =?utf-8?B?YTA1clRRZk9QdjhyemxmN3pEdnZySDBOTk9JQWN6bUFyYzdsRnBFSVVzUEY3?=
 =?utf-8?B?UUNHdW5iSjFQbmhqTk5pWDFpaWh3bmxtYXlVVFk0M2FhREVFd2xLbTFPT01v?=
 =?utf-8?B?eEVkazNvV3MyWnhlMWxaTG8xQm5BbUtoRk4wR1RnbTc1WFRUbjEzYUZrWEd6?=
 =?utf-8?B?Kzg5YmtuTXVRdlptb2RWTyszMlI1TTVPZzhiK1g4bHBUS0U0dzNyb3hRRTFD?=
 =?utf-8?B?RDBaYi9rTWVKUkZwRVExeW5UeGdKZmU3eWZxQjU3dlIyaDB4UWVMc2pxOXdp?=
 =?utf-8?B?ekxnRTlrWmpPd3MxZEJ6N0xycllmL1BwY0VzWjJJbE9qWDE4LzVuMTVGa1Rx?=
 =?utf-8?B?R2NqTHdnVnk1aU5qY2M0TnlIc09pemNRS1IzMnM2TU4wUVNmZHB4Yk51QmIz?=
 =?utf-8?B?SmNqb202Uzl0dmRONUlReFJraDlyZHF4LzZOTzdnbk4zaEU1VTVYUkRvdmFl?=
 =?utf-8?B?R21UWHNkeE9BajB5NjJaeG8zRVVMdzFUa05BZ2xaam9LTGJ5MjZOV3krSmZW?=
 =?utf-8?B?SFZjUkpxcTFiR2U1VjFvYm5mN05DRmJzVG5tNDhOdEtGRmVXRWhPK2pwVEto?=
 =?utf-8?B?TlB4QUVxYmUwTlFoYmpuaTd0TFZKa1NJdFVTbTIyNURVNERmcHAzUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9326936-bd61-420e-b311-08df4085a003
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 06:24:37.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrADseA0cS5QYBuYvWoGeLsvFnZXEa3ZGo8QcI8IeYkzFhvBeFWbTmE5Lh/ctWKaV7if3tUvHT0cJWVql76f/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12098

On 11/11/26 22:27, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Use the dmaengine_get_copy_align() API function instead of directly
> accessing rx->device->copy_align.
> 
> No functional change and prepare to move struct dma_device to private.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>



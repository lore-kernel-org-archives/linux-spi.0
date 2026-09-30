Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3A478869;
	Wed, 30 Sep 2026 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769522; cv=fail; b=cTZltuQWH62pVyvs2zsiUf4v4SRCeabSQ1t+9Xegj2/rysKVWQpiQfVfl16W2Ivg8ZTaWPFlHARBgeX1/9gX3gf8CMbdM9OD/ob8ppc5TefJjNWTG0jVXUQZ0zsrs/6VKR6R2GhRiXC3j4zZGAjtXMhy4F3x4KU9wqmyTlbSpuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769522; c=relaxed/simple;
	bh=Tl0RwduXDAHJnDr8c0FxvgwYQJZoYe5+mmm1lka5rxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H3mpoTiUvmNLjvQKhAXiLE0jZoo4jWRJn17VjXDdUAXOTEqw4u6hPVBMmIHxGYKh1cvDdNrqGHzTiBmVZpDgF7ioSAuleKdxj6dZbOPOBgMeuS/1Jk5UsZjH/b6Reh7nGsBsK5wsoQsR1+yL5KNIm1p6+4tL+qV70sdbJ5e97CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BQRlyCpz; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BQRlyCpz"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UBoSOu1599098;
	Wed, 30 Sep 2026 07:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hrQyc
	kRhVvpKvXk0AFEO8iMEuKyioC4h53IS0SNqbS8=; b=BQRlyCpz12Rz5DXS//4uB
	yJSFcGLx5zux6s8fI1g4jKhFR6nftYkjxtiUpyPtQwcbE+7M7CmIKZCRxD0Kgwlg
	lvK86QfHFWyXFdbbFRKvPz+3JL2yFxOjEukQ1PJOMVpl4mGp5HSUzTYYMXI4O0rk
	5iv/CBti3ZIffBCEyJ2eBkN9ucz/MeokwkCb0RX1ChwsAuCiqcxObec2SYsGKANg
	EJUg8by+tnxFBXXSetnuOhhEA1FzcQ63IOxu7mlLTKV66jvbk7EuSw8l6AvxoVh3
	au7YzzHNsCIhPw1mOz0NEOBSNsPSAyg11pH6+pmf/lnSNNHD9Kiao9GpTC9g37T7
	Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h107bgm37-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:58:35 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8QFbF1eatgnhR5MBFRFytKqb+WReTYfitpqKuKj3UTFLjOlP+3Ml5q5zzZuqvyA3z+viUflMD2byRIO4rlpjeudbpEXuk3ayFmZRIcsUttvvvHK837iZRfPPR4p4rcUQJQ5oof+lPdNvvW9wzRe8sPuyWBtBYWE1WaFUC0h3vF3tOmD2W7PR50nGVO2QMErQyBQezLvEiymmQsFxVLFOnbQS91kUOIYCmD3d4UtgYfqqf2zhItEA3nHHM9qUxAVO4nT5pBQLrneJ7iEJ+Hd0KowKnYdyFhLAzGQ/p5z7qx9BZB8jY99dwBWmlud+GpRoJ5QTzZw9SLlXGyD14Cqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrQyckRhVvpKvXk0AFEO8iMEuKyioC4h53IS0SNqbS8=;
 b=UgTfvdW0ybhRoz5Gk+wRyXD8iZemkMA/Gj2RGKj4vDoTKCagGeff9hTb3Y9IgTZxLwf3pD9qShCARJP9ukCikLULEN7xejbc69YGUn4yL1FvJP+1T7nVSf5mlh30NdCkVmRucHFKPW5Ufsb9J6C5NiL7BVELGzdMVHq1Bc0oysPTkGlv8HLzIicixiNOZg3ngSrx2WJEjbbKgTeWN3On/8kh6c48Yl/1UokETeGxDwVcTTlDQZrca3oJ+8yC3kkaIFF34HoGVg85ilScIvPbxmt2wf6jNqvafjCZvt7Qmi1HQFXfDm0d2XwgXK9E1aRT/A6lhxDxGH6I5mhoj7UP8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by IA3PPFD02CEB313.namprd03.prod.outlook.com (2603:10b6:20f:fc02::2d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 11:58:33 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 11:58:33 +0000
Date: Wed, 30 Sep 2026 12:59:44 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        dlechner@baylibre.com, broonie@kernel.org,
        michael.hennerich@analog.com, jonath4nns@gmail.com,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH v2 0/2] spi: axi-spi-engine: fix stale SYNC IRQ pending
Message-ID: <arz5m1reIpvQTAsA@nsa>
References: <cover.1790731588.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1790731588.git.Jonathan.Santos@analog.com>
X-ClientProxiedBy: MR1P264CA0009.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::14) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|IA3PPFD02CEB313:EE_
X-MS-Office365-Filtering-Correlation-Id: c46a4f97-5231-4d3b-3ef5-08df1eea269d
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|6133799003|10067099003|260925021311599003|260925022911599003|260925021911599003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 CNzGd04wfvrZB8WLz7Zh+ocVU2WxdORmnE9vJwHf3e4b2JYtQRQt4ngsQunyV/npFCfCXsPQnXX9TWyQbjGm7fpTYaHyQJuRzklKPWDFof8x79ir+jnkOJ0W7oVKLJVUk3GuD6O8LPWFtouoEIxDPvoKVdZHjB7P6vRgq/OWmojk/aiTdbtYvExAjSiN8jdt6DnlpJA1hxBPvCmALykQjz3NLLKa8mX+NuCQMKAyk8yKP9YJnv5cSNAtTsv+YYS85cszdeuARRbSceXlSerJe0xbECU4sph4kgR9lXIj8NSJTA54FTImMViHGPJjyNnZdkBPg1qkDE/ZwDP07G9U1Q+fFl67Kih3uz1QSva2TMvD9bkKaSdbvDL2Ot8rd8d2uVCTc5DqkGLnbSArGYdJK79bRGHnvhqx5v2xcO7bozIc0Ig1N9VvNCW75I3kxTLXqVSY0S9X0qwYtVWQQGqZpewFtkaF5gzEggvHi0yJGOR3NCKHM0HT1EEm33Ute8TviRMPM1947e9LK/e1cvM8XH7Wym/iHGcTYdnpEBHQD1EH1SD/YuQaZ/4GfOe3ycQcfgC82I52hN9jUdexLe9XHh+dzCwM1WIEoBuFmaATWsGRZg1UDdWATbsg3mW4+Rvg
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(6133799003)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cDdSRUQwNXNVb0ljM1FSUVFaeGxWY1QvUGxRQ3lGM0lKWE1ZeGdTazNxTXpX?=
 =?utf-8?B?dTlJbGdnNXYyYWtVUUpjSG9Fblg4ODZLSHNOS0NTRVJTN2RqZTErcFhlUXRY?=
 =?utf-8?B?dW1uWk04OEJVd29KeWx3UWEwcDdOMEdWNTducGRrL2U0cjZnSkNPbGc1elZU?=
 =?utf-8?B?VzdrVDJwSWd0dS9hRytJMHJwQ2F3UThRdUx4WHlvUXJsd29HNEZKakpLTHdk?=
 =?utf-8?B?aGNBMm1nNWE3SDJQd1NqYmVZOEtGcDFjeVZrTGxPZXo0dE1ZZE5BYWpVT2c5?=
 =?utf-8?B?ZmJIZXNWT0pRZVZ4ajR2SGpwdGMvSnM4Q0t4WWs0VjB3QitTdnQ1OTNHU0FD?=
 =?utf-8?B?dENXSlFPWnZ0UVlVU1BJR0hEaG9qSThWb3J1NWExTFY2YU8xZW16ZWZyNm9J?=
 =?utf-8?B?RXJCNGtoWFIxbmszeWlkRTBzdG9nUDBjR05udGVzNHcxUmhBMHUyWVlWWnNY?=
 =?utf-8?B?dVY2TnZmWTlUdzJ5RTlNbWZlT1ppNWpBaEI2R1htNHBGQ2lkTmhGTGRQN2Rs?=
 =?utf-8?B?RWs1R2F5aXlOVHdqbVZKcFg2MFFFd1dDcTV2R2c3REpCR2Q3RWtPc1ZCejdM?=
 =?utf-8?B?TVlRand5RlJqdkRCY3gyQkxYVHpsZVB0dE01MGhwbGFmc1lFSi9SNWN5dVdP?=
 =?utf-8?B?MkwyN2VIbWZvM09URVEyK2hRQTFxNW5VdStuRlpmNGFhNEc4em9NcExOeXYx?=
 =?utf-8?B?REtIbldLSmdvcGI0Y3N0ZjdTa01WOEE3SWR0Rjk2SEQ0UTVMZlFGdFlFUEpu?=
 =?utf-8?B?ejBqREtCQ3BDYXJEcm4xTjlvZ3NMOFVUVkw2ZytGeDh1UkM4dWNJaFp1SFJV?=
 =?utf-8?B?cmtuK1RYM1h4V0xPck9qQlJuNkw2OUc0L2JUakx4d2xCY29mNU9aS05uT1BD?=
 =?utf-8?B?c1h1dzNrdklpNzNxcUJvVldlTXRhVjFESWs1dDFPNHdmcG02QWp0TUlIWm5l?=
 =?utf-8?B?RkUzNU5FT3J4WWxhcS9oaVNxQ2NkcXMyQks1SkFta3pRTlFjUk5lb2R4V1Nn?=
 =?utf-8?B?bXFWeDNxSlIzVkxNaUlJcDhaQThyQ2Y2aWFHaUJjZDlWWk1Yb1hoa0ZqazF5?=
 =?utf-8?B?eGdobmlIeUdPZnJKZitIaDdmNml4UUl4aTR1cG81em1yNXVxVXBiWW9YUFBD?=
 =?utf-8?B?K1ZlQXl1R1Q4ZEJTeElPNUdxMGJ6QjVOMkZPazkyWld1cGgxTnhHOEVqVHV3?=
 =?utf-8?B?Q0F4TXE4MUI0Znk3dTdCS1owajBaRm1TTGowOUl0c0ZkNnpqZ2VDMHpEWGVv?=
 =?utf-8?B?WlBJZFlzMDM2QzBZMlZ2N3FWblFPWFlLaFRVczBNOHd1RENFZTU1d3VmQUxP?=
 =?utf-8?B?MENvR2ZoNG1mVGt3MHJNQ0p3MHVCeVVlWE1pV01pZm1oZys4WWN4aE9VeFVE?=
 =?utf-8?B?bXFsZXJod1JPZ281OW42ODZuaW1wVEVzOXgrR3dETEcxK3NYT2RNSGdWOGRv?=
 =?utf-8?B?cW1xeVVBL2lEMjZXVi9MTzladGFmOXFxS2FYZkNiamRTRFJqZFFNZlV5M0hQ?=
 =?utf-8?B?V3ljYnpHT3F3NzVLVmxxSXdPdnVSMFZ0TkgwVWcxbzB6bjN5TytLT2NHeVUw?=
 =?utf-8?B?V1JJem5JWTRTdG5Edk5DRzFabWZDVFVCWEhrQ3F2MVMwQzMxZWE5ZFlIQTNT?=
 =?utf-8?B?MC9aRG1Wclc5YlVtSVkyaERURDVBc3dLOE5mZUhXUmRNNVNHK2gwcWZ6eStU?=
 =?utf-8?B?QW9IOWlVMTI2cnF2eFdnQlppZm9CS2J6aEZ6eWdiSXQ1eHJyc2JpMGtOay9Z?=
 =?utf-8?B?RFV1d2NYNHVjZHJScWsvUGxSK0cvSWdCKzZVc0dVajhwWm1sZERWS0c5dUNY?=
 =?utf-8?B?QUo1cDFwQnIvV3U5TFY0L0ZNWjB1MjFsYVBCblV1cHRtT1dCbjRWWFhHTUhs?=
 =?utf-8?B?WnY0TXlsZ3FqUXdDcTNEMjZBTy9KOUFuQmFmeDBhQ3RKeGZMMFNIcFJCSTdv?=
 =?utf-8?B?MEVFbU0wSHVRTFhveFovQVVhVmExUzdLLzZ3QUVjV2FQcHpmeElEN1dJVkw4?=
 =?utf-8?B?ellNdUtCVDBCVUw0M2FsNnJUS0U3QlErV240bjZUemhIUzdId0NjVGk5a3Aw?=
 =?utf-8?B?UktXZnhpUE1XdGNHTDFQYzRBQkRXMy9jRm5BanBlbkFoaFN4OTIxUEpLYVR0?=
 =?utf-8?B?blRsRUREM1ZzZEcwYVQvRzJEK3NIcHpCVkVXL1F0bldDZ2NNalY1RDVkR3RP?=
 =?utf-8?B?ZlBRSURadTRlTmRLcll5YVV0K1kxYzZzMlVibUdZcThnUHhyVU43UTloRVp1?=
 =?utf-8?B?cUJOSXRJTW11b0JhZHM3ejBzOU1LbGthb1F6dkpWR3RqbVdVTmhMSU0zajdu?=
 =?utf-8?B?QnZPL2w1R0x6Z1NSN2M5V1QvU284ZlZibDZrdDllZms4TlhYblo1QT09?=
X-Exchange-RoutingPolicyChecked:
	U24o9AN0tN/XEMiyedjWDml8FTU9PciQlfb5Z1EjGBczHaoiLFkJN4ayagD9La9JuUqXYY25uB5zuAbH25ZNXj0KARb/XtU3Qh4pi7ArImEBchpz5tyx3RUhAh8suvvpnEPkN0d1EQfHOAL3WnR4q+HGMBDw3Tp6+mPoNfocGuIFHuE73M0lsDnZsyuqlHvGGqA4q7DzLcAwSXP00KbL4xhHSW1YBBufzxnSPqa6J0wr2vesVBqhgjznMaAPOTHUIfapP4IPaYFsPNpP9wadZlxizD4JYCQfiJGc0rUjaPsAYDD/506lrx+i/9dE/Wt3m3fgwmCwcVmhdwZgoK1sAA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46a4f97-5231-4d3b-3ef5-08df1eea269d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:58:33.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzZGhKyAxLuNzYm5NE08lS2CuFBl+wUy1iH8nNNjPczJwNDARtrIYpp/bLhNv3s4nFVFm94XmGc1O+A4mnIX0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PPFD02CEB313
X-Authority-Analysis: v=2.4 cv=TdUDJhQh c=1 sm=1 tr=0 ts=6abcf96b cx=c_pps
 a=L/RFU+sPSyhylg1snxNseA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=zoQrvhA348sSQ3Uc5CUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: h6kEEk58lx_4-NX1fjtgQo7eVICQDX_9
X-Proofpoint-ORIG-GUID: h6kEEk58lx_4-NX1fjtgQo7eVICQDX_9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0NyBTYWx0ZWRfXyF+AmgBgOwsY
 PMW4YnIxBhjT3g0I4lHX/facIoz4X/ewls7H11ahUVG6R3gilzkaxvdiq/REY0bqJrIdo3rF9WA
 aeCBSOoa8nkYg9KYQ3lcAVfe4BsfmPs/GCIoamAdVN3xvecb093cPTBzgRHeuTKXNA6jiRaWfFr
 SfXHIsP/M/nCo4qHEF1IpJxo4BlAorHb21vXUIVKaAyfoqiWU0iZNmD0PGlw15KNaXt0HrShWFb
 9T2A9YgtWcaskWvoj3ToET11ALPdrNatYtcvkQ2k/zf6JzRjhexCvZOAXs8lZNJhMxAJVRigFEj
 qXYlIlZehiALwOMUDs0YLcgcpk1DewjMGQ0AmjNFB5x8TMC9PeKgOkVFvocK69za1wf3LhuVqjp
 SxcjE4ONdBoV6J/d8mLur1452SlcZ3CRaYkKSOmm+Xo024XyzCBUi+G5Xcm5giJDsBJYzk8xe7t
 Wq5TKZVzJNY55U9inag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0NyBTYWx0ZWRfX9/lRDZf21J7f
 djexgUnR6LnEJ3czbG6j2DofL64u3y7/92LBoWCZAl9htWtt8uXt18Nf8lf6lFc0bTrcjsUa+66
 +ExHdLL/6kxvpnIbgyIWmLjgXfd7a8IOoz1fKTpN+Nr4i1hF/vAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300047

On Tue, Sep 29, 2026 at 11:17:06PM -0300, Jonathan Santos wrote:
> Both spi_engine_setup() and spi_engine_trigger_enable() send a SYNC(1)
> command and poll SYNC_ID, but never clear INT_PENDING[SYNC] afterward.
> This leaves a stale pending bit that fires spuriously when INT_SYNC is
> enabled later by some driver, causing premature transfer completion at
> low SPI clock frequencies (more likely). Fix both functions by clearing
> the pending bit after polling.
> 
> v2 summary:
> * Replaced "Link" tag for "Closes" tag.
> * Included "Fixes" tag.
> * Added new patch applying similar fix for the spi_engine_trigger_enable(),
>   as pointed out by David.
> * While at it, replaced plain "1000" by "1 * USEC_PER_MSEC" for better
>   clarity.
> * Link to v1: https://lore.kernel.org/linux-spi/04d51e99b8cddce51113db933d806e83848f04f5.1788313558.git.Jonathan.Santos@analog.com/T/#t
> 
> Jonathan Santos (2):
>   spi: axi-spi-engine: fix stale SYNC IRQ pending
>   spi: axi-spi-engine: fix stale SYNC IRQ pending in trigger_enable
> 
>  drivers/spi/spi-axi-spi-engine.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> 
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> -- 
> 2.34.1
> 

Reviewed-by: Nuno Sá <nuno.sa@analog.com>


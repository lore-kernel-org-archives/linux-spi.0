Received: from ps81.spcmail.jp (ps81.spcmail.jp [52.192.49.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175DF38644F;
	Tue, 14 Apr 2026 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.192.49.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153372; cv=fail; b=PYW+rtph2736lRS2tb/X8BLh1HkZf3nWopaBiG5LWuLZeWIFcrHyDVhTryukauSfMgTTmzE15UZHmyMvYA1SxRxAbmWigr/LWmi5RVx8T87NOxOChuisXSDLJZEB3Uyu5C2OoEPWS0BqmPEs9zgBMc+gkfLC4j9wy5jyIUehSfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153372; c=relaxed/simple;
	bh=c6otThnVmBWGPt9LtptMoYic3iq+e3h6bpSJkSd5FMo=;
	h=From:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:To:Cc; b=Utp7NVp0wPwSO4KNjxjRKsAZdOthguUurL3b1VxbxSe/QMgI4oFzH60zmMOgwKY9fld2ocN2hUX5t3uljZACJpec93irqZ8fNEn+q6MiyHPRMgNgph+6bt3O2wEUAjB0cC5pqFGNraGjoBC8q3PBHeWkIhLh6HkSjvWih+2cxQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; dkim=pass (1024-bit key) header.d=SocionextGlobal.onmicrosoft.com header.i=@SocionextGlobal.onmicrosoft.com header.b=KKxgESqc; arc=fail smtp.client-ip=52.192.49.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=SocionextGlobal.onmicrosoft.com header.i=@SocionextGlobal.onmicrosoft.com header.b="KKxgESqc"
Received: from ip-10-10-30-85.ap-northeast-1.compute.internal (localhost [127.0.0.1])
        by ncs81.cs.local (8.18.1/8.17.2) with SMTP id 63E7m3Mm2003213;
        Tue, 14 Apr 2026 16:48:04 +0900
Received: from ip-10-10-30-82.ap-northeast-1.compute.internal (localhost [127.0.0.1])
	by nmg82.cs.local (Postfix) with SMTP id 4fvxGC69ZYzMpsj9;
	Tue, 14 Apr 2026 16:48:03 +0900 (JST)
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011024.outbound.protection.outlook.com [40.107.74.24])
	by npr81.cs.local (Postfix) with ESMTPS id 4fvxFy4qJSz3jcDV;
	Tue, 14 Apr 2026 16:47:50 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWbN7zLWUDW2cg9TbMHfOu3ywcnS/sVjRw7sWR+QSACFSF1/Jt26iyVWJOdCDr/KBFk994rczcel+jF1T1vGm/1rzGV57FrtkAfO14DLMOb79uMQDB/B/zekbrBk3lp+HWYbWlkn05QCTjZoFgGCU71ytovj9g3fKW5EDrUejcQhXan1uI8iu0CLus8VxQ+Y4lyZh+7reG3oBQkXnHoKoksEkamc1S3Ole1yQEmbLeUiNhTQ4rZ0EBPPXgXZX+5qLE3Z3u7PrftFY17CMdYWgHfF/LBR90Q41JBeDJN/N80qt4eNBl5Wn0uecD6ApjhMYbXnk7Rhe8VEYuOsxg7/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUWM589wOl1aJozigq6BKnHIstSc29SxG1r+UqF515g=;
 b=kZ2dlhtZhuUhWZW5xgsFxX4tlHURXDXrIVy61/7eD/GP57UcBhFJ2Qtq7UCXPRgYpm07vU2hns/1MTEJPxN7EHsTG+cYExssUznBklSM80xdqVTB+wxJpS+tUwJfZL83u1zNt3k0T1hkyZvWVLj/b9aSh/w8xrTwpNuYJg61CAItpzl2F1HcZMr1D1wrns8rcFnErTW0DZ3xyCqHONU5xuduhTOmtf6v93/gQFzzuZyrVMDUpT06vGT+YdmM3NbFOMvrAo3I4Y+aSbjiIwKnf+JQ6zQ1gvVoVnLhFgMsngJQ8njsChRtCjOcyZt9TJv+fit6ASgnxQLbOvLJXrR7cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=socionext.com; dmarc=pass action=none
 header.from=socionext.com; dkim=pass header.d=socionext.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SocionextGlobal.onmicrosoft.com;
 s=selector1-SocionextGlobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUWM589wOl1aJozigq6BKnHIstSc29SxG1r+UqF515g=;
 b=KKxgESqci8kx/0icusk8o12ZZEq/XqAujN3vt7nEFDVu+20bUGSF8/SDoRPw7TIE+tLhOFoUDvJaPJg7PSIPiEJwqPYxvRaJZUHEM8GsZjuYdXanoDjj2aWlZD0kEM9IjAdafu7XM/MriPGhDjo2BGVqQwLQyA5eFbGaMxwwBH0=
Received: from TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ca::13)
 by OS7P286MB6668.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 07:47:49 +0000
Received: from TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1a2a:2bdc:a0d5:99d2]) by TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1a2a:2bdc:a0d5:99d2%7]) with mapi id 15.20.9745.035; Tue, 14 Apr 2026
 07:47:49 +0000
From: <kojima.masahisa@socionext.com>
Subject: RE: [PATCH 1/2] MAINTAINERS: update Socionext SPI maintainer address
Thread-Topic: [PATCH 1/2] MAINTAINERS: update Socionext SPI maintainer address
Thread-Index: AQHcyMTh3y3qAaPv+0ikSs1417G1IrXeMYKQ
Date: Tue, 14 Apr 2026 07:47:48 +0000
Message-ID:
 <TYYP286MB092432E7087CDA47AA101737E3252@TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM>
References: <20260410083423.504695-1-johan@kernel.org>
 <20260410083423.504695-2-johan@kernel.org>
In-Reply-To: <20260410083423.504695-2-johan@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ccmail7: Relayed
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=socionext.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYP286MB0924:EE_|OS7P286MB6668:EE_
x-ms-office365-filtering-correlation-id: 704454b1-178b-4a6d-9e60-08de99fa1ffd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|1580799027|38070700021|56012099003;
x-microsoft-antispam-message-info:
 yAy5pD/ngNzf/3sAK6gXU1aO5gEKIyzdhsNEJCc3HXMTd+EFzf9ykOa7Ssub9AYXX0fmclZQ/0/Ukex1pBquyXIvP4pP3g4Dk9oWspTJpl3mEF4MXT3KuoFLz0CJGWTcPHODYLYJCIWhiXWjAoiaH1y1llGSF2h/rV7w3MLeI1KUBxmbPuP8CAj5VdOfdqjMxzLLrHzuBLw9hLub9ggNNePmcmvpFL/F3MHyc+LZcQg9hz/wdll8Fy2OPR7Lsc6BHcbfZebWACILc44LzGGa+WDhZawTSPD9I9hNHECHilob+r9aARcTSMlO6CRQVrUSCcg07OXkFclgA6SSNsZwGTDaLjoY30KtgwYFLraqGz2IoarsipfZScG0wkveaV/h+pP/HPk24zYxpO+INVopaSDhn6i71J8ldFQj6Tb4HQbfN/SStYOw1YPE7ddcmf2Wfs7FzL904XPAA1NpIGLm0+AqL+WeqSmxxUN+n8vHKGLCOtPNzJKJCoG3IxiAsyW/5l7FnNKqvuvBlBVghF9LvuPieS+PoIz5Kee6UOHKIoOYix2kNLw0Ba5/RfOdys0dzlSGp9zf6lWIlOIplo8CsOAeop+r++cXVYx2Ai65ssMIXtYOZOZKYgbW/E4N8MjRNrVjp7H84wbuocCcQ5A/ppgGkGaBMIk/iPXhQe2iFOqzKLAe8THNGJN+t1Y1e/tf+HHqab9FrNmm//zZXze3qpf7mKhBFDy3hQnA7YgwrS9u9q0ChYXhSJGakDvdhv7oL95SfVmt6BbpbIaaTXvPQjoXHSPBm70oKajXmqVnxhFBSf8uknqhHZ/N9phN1exX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(1580799027)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Q2ZKYURmeVYreTJpNnJUY210YzRzWnhaRDZkSVBuYnhtak1wdTBOTlNB?=
 =?iso-2022-jp?B?bUUyYWI1MnB6b29SYVF3c3J1ZlVXTVZaaGV6bGNBYmlVdDRUbjYwWGdQ?=
 =?iso-2022-jp?B?S1FGbjRBTWdhdTVMTWVQUnk3NEtSMk1mOWE2d2E1SzIvVWpLbmZPK3Rn?=
 =?iso-2022-jp?B?UkQ2LzBRY2NnOC9Pd2I5RWExVWwxSmJwZFprV0szR2RMajlVN2YybGJx?=
 =?iso-2022-jp?B?YkpxUGF1OEFBai8ybEhRMmpLdXVPcStSV2pXUFYyOFA1SnFUVGhEWDBm?=
 =?iso-2022-jp?B?WVkxR3RoY05mOUdYRG9RR2Vuc3gwVDJoNmVvYTlvbHh4a25uL0pob2NK?=
 =?iso-2022-jp?B?cC9sQTdoaVlqV1ZyOTBaMlB6bXlQL043dVpyNGxBZkN2ZE54SGxXOXBT?=
 =?iso-2022-jp?B?YThzeGNJSEpmamRRT3BUSmh1Zk9VL2h6aXY2b1FHYkRKaWpuSEVFQlFR?=
 =?iso-2022-jp?B?RDA4WVZXMU12bVpJQ1hpbXhwRFBEby92RVFXVHJ6SWFFbE5jSEFCbVZn?=
 =?iso-2022-jp?B?MWNOWDlrNEZ2Skx3SytwYjRuL3VNQlFEYmJvTnVUR1ZSN3JMUlpHZEtv?=
 =?iso-2022-jp?B?OVk1Qk85MWNFd3dmVjVUTkhVT2R0aVp1UWxyeUhuaU5RSXNKdFhXLzRo?=
 =?iso-2022-jp?B?SHMzOUgzV3Q4NGlSTkpSNTZ3UmlCQUZ3aUJJWms0SUNMMytmN3NJWHR6?=
 =?iso-2022-jp?B?ckpYT0pJOGxJS1llb2RNMU9HdUNObzVMVExDc1JHbGlKNzJ6UlpPVDQx?=
 =?iso-2022-jp?B?a0dPSVJEUjBvK3lFV1FvM3BWbnhIWjB0cDMvc09mUDhCalF5Ry81dE52?=
 =?iso-2022-jp?B?UHE1czlFKzVVNjlMVHhrS0xscW5aUjgrOXc0NG8vMGNreDFiUVhJOHVs?=
 =?iso-2022-jp?B?VFdtU3hMVTFkQ1h2MFdrTEN6TnEwdGJlWUlmUU0vOXBiQXpjNWFoUHVM?=
 =?iso-2022-jp?B?OWdsbVpHdzU0dVp0UVBEZmdpbmVXalFaNnBURWFMb1RqTy90TDFSRkx3?=
 =?iso-2022-jp?B?Njh2WHdIblRPcldnOFkyVFlWeW14NXFaMGRZbEk0amFySEJ1NUpZZm9N?=
 =?iso-2022-jp?B?YllPVzArV2JVKzR4b3o0RXB6akhtQXg0a2F6Njl2cEQwNUFmK3hwZWE1?=
 =?iso-2022-jp?B?dWwzeU1CSXlyOTNlVmloWHFOeWxERzVETG9KT1NmaEhSa0d1eTE1RVk3?=
 =?iso-2022-jp?B?aVRQSFZZTmJiV0hRUG1Eb3ZqOVc4L3d6WjRIb2I2YXYvTDBtK0h2R2No?=
 =?iso-2022-jp?B?N28rdm5FVHNrc1llK1FWNmIrLzg5YkNmVVE0eEczSnFnRUordTdtRGNJ?=
 =?iso-2022-jp?B?Lzd3d2NrU25UWFhiM21XRllzcEZwWGJac2xuVEtMb095YkZYTEF3V1RI?=
 =?iso-2022-jp?B?VFhZUVZUcmhHT3V5UE1KYld1NnZOaDVuYXUxQUxmRjJmelFKTXhOWExv?=
 =?iso-2022-jp?B?UFBUSW9GK0ZTNFJiVjVkN2xaYXdTbGYvRWp6Ti81dVVxV2prMm85WFpF?=
 =?iso-2022-jp?B?YXI4ZHBuVVFKOTFsdjdmd2RXdEVQblVtMWZkSUVid3RLaGxZd2dvL2Ji?=
 =?iso-2022-jp?B?TlVNV0xUd0lKSjR3NUxOWU5TaktQUFA1UEVxcUtXZE9zTE5EMnBEbzZO?=
 =?iso-2022-jp?B?d1VpcUdjRElzN0RLUGlicHlUNnAzMVJJQ3dSdFBONWlGb0ozaVRoYyt3?=
 =?iso-2022-jp?B?U3ViWWZYV3VTTUdKT0dneGwxclYzSCtrMm1pVGViV0RGUFFUeTE4ZWRn?=
 =?iso-2022-jp?B?SVppM0pvb2NWak92ZzUwT3lBZE0rVFhVM1dla2VPcjhxeXQrcFlGMVRZ?=
 =?iso-2022-jp?B?K09FNHNSZXZhNDJmd1NNa3hOcDRGcHYvMjNPd0JGcGlDNS96TmZZNEpi?=
 =?iso-2022-jp?B?RHRnMjVKRjJoK3VPd08xcUxqQzJjMEkvTjIveXozZTNJdmpCUmNLWHk4?=
 =?iso-2022-jp?B?VU0yWGxyMlEvcWhySlJHTUtncGZ3d1JMY1l0VHlwTHBFNnVmdmJ4YTNX?=
 =?iso-2022-jp?B?bmg0Smc2SUNpOEMxblhjc0R1Qmhqcy9DRmJjM1pyb0JDSllIZDhnZVdC?=
 =?iso-2022-jp?B?QWwyd1U3V2k5YXBKZ1NBSS93SFdWa1JpRlhhc3JCV3YvTGVDY0hPekxk?=
 =?iso-2022-jp?B?T1czNkdvcG83NkczaTM2UFZaNnlyQmNlbnFMTUpESU5EdFpTcXVBYVdp?=
 =?iso-2022-jp?B?Wm5XbTZrVGdwMlI2eER5M0UrU1JBQ2tTS1o5QVNmSzhMb0VZWmdYQk9V?=
 =?iso-2022-jp?B?eUthOUg1NXI1WE1Ba1FXZ2RITnJseU5aNTVzNW9Xb1doL0FaNzMyV2Jy?=
 =?iso-2022-jp?B?V1owUWFiM0QyMnR0amt2MVBQbU9XaytmSFd1a2VzTzB6c0k3Nk91R0N2?=
 =?iso-2022-jp?B?cTZJUXYzclpCc20xMFlTdjdqM21zY293ODZpUXpvay9LQW40Z2hydlRa?=
 =?iso-2022-jp?B?bHNpMGdvVzg2S2xOa0JiYnhhQ0dCYjNNMHZiWVllU2JDMC9CUC9ES1Ax?=
 =?iso-2022-jp?B?NjZRckg5MWIrOWdpMXg2QkZYUCtQeG90cXpBd0t5a01yOEJMaVJNcnBD?=
 =?iso-2022-jp?B?K3BoK3Iwcz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	QS6q+b1i5dn9NA4BT2MT8UYgVGq503v92fAzrByee0oi+w2I8XuhcCfucK+UqQNPZvj944tFiySE3WSKT7NA4/Op1TupIgT7CIirwAvBMEGAN6Bvg2MkZSpJHYui76PWYIb9n+Lt0wzT3hrBIenPg0EajCFVWZSwVqmWDg9QmNqJLTW2dFpQwyvi53a0aQd2ljYs6L2uqGDkW3+ASlPv3UAtA0vw1CQfg989pfNbDSczrgsHpCN1tq8bD7EMDylJkWAkZTSB62iVXxWJWT5ANEyijyGUjx76dhK5Bbq/vyC5PlYbVmQ9NQno6hdgwqLOObweYOZXjAAZzKig1WmPgQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DRAGpJhwHDKvgtAzorbDfVoA8O7jTofQOHP9U28S7kN128jOguy++dQ321ifW62GshB5Vx4S1X0jRANcHC8v4lNX5xV1MYxymDqUyfNHsaUTszeDA6YQziVgBuEvpVveUtuC10VLLaBshSrdTJdl1hYXQkn9YxKt4qzlgPUHJUnXsDFTq5CIJNdRLZmp/FSRM3uSpOJIt0a+4WOJpnFdfDPn7qMZKC1kRE50XUcWmbyyT0TMmCelMD/TWQVPGFYFxeC4q4/erBpFuQN8cpwMbBjtIbe7kNPfLBiDO+99YOQi0U0sBSG+5SuAOy9QcSQlYkjO3HDx3UQdTtrGV2+L1OAXyIZqdWSrGHN1DdaQ+Gs0/dd0YPe+oPm6Wv3Eo8eqeWvb6j2qESY1NOuUHiYipEWDNsSudLXzGoIvhcOwiEZsbskDbKMOqt5vutkd1zmzf+tQEg9+LtttlwZjITVDfhHJVw6y39bymw6vV2QT0Tq3R/e5ZXVfrnSsU1OI8UcexKLoR/2tB3RcLHkP8ZPNYZx/UZvphmugrbLtlxYfgoVFfZBB9txWx0WRL2NrRLLeFpoIMJdd9+fBAFdoSHWOdB5UfkttD4ehHuR27rCHJrwPihZhSw0MoDEphbiVjeKOfnEde3PVCRnq+VGTtRZs06O1ERr+dDKAI2wPjokdEk329m0MJIFVjg4qS+8jA5hZENP+Uc+of2lBmo5+X6jC/xOew7L+n5O7G8hdPPoMmiJij8jIAmy9u6GyQaqXqyHC
X-OriginatorOrg: socionext.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 704454b1-178b-4a6d-9e60-08de99fa1ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 07:47:49.0515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33c08a51-ea9e-46de-8669-aff1f467d3fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxBc7i3AmEsp2rAH4VduUhJCjvBkAew9NliPKhX9IGSKiZ5TpSH+ht9SHbzfFZ3q/49Kj5JFHC37IpMzy6oakDgPd6ANEL4WlzZwzSAQH+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6668
X-CC-Mail-RelayStamp:CC/Mail Relayed
X-CC-Mail-RelayStamp: CC/Mail EncServer Relayed
To:  <johan@kernel.org>, <broonie@kernel.org>
Cc:  <jassisinghbrar@gmail.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>

Hi Johan,

> -----Original Message-----
> From: Johan Hovold <johan@kernel.org>
> Sent: Friday, April 10, 2026 5:34 PM
> To: Mark Brown <broonie@kernel.org>
> Cc: kojima.masahisa@socionext.com; Jassi
> Brar <jassisinghbrar@gmail.com>; linux-spi@vger.kernel.org;
> linux-kernel@vger.kernel.org; Johan Hovold <johan@kernel.org>
> Subject: [PATCH 1/2] MAINTAINERS: update Socionext SPI maintainer
> address
>=20
> The Linaro address is bouncing so switch to Masahisa's Socionext address
> also found in MAINTAINERS.
>=20
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 213f6a294a9f..e22dcbeb7132 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24465,7 +24465,7 @@ F:
> 	Documentation/devicetree/bindings/net/socionext,synquacer-netse
> c.yaml
>  F:	drivers/net/ethernet/socionext/netsec.c
>=20
>  SOCIONEXT (SNI) Synquacer SPI DRIVER
> -M:	Masahisa Kojima <masahisa.kojima@linaro.org>
> +M:	Masahisa Kojima <kojima.masahisa@socionext.com>

Thank you for the fix.
Acked-by: Masahisa Kojima <kojima.masahisa@socionext.com>

Best regards,
Masahisa Kojima

>  M:	Jassi Brar <jaswinder.singh@linaro.org>
>  L:	linux-spi@vger.kernel.org
>  S:	Maintained
> --
> 2.52.0





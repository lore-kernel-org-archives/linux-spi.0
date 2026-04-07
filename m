Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DE539B483;
	Tue,  7 Apr 2026 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548916; cv=fail; b=thxsvLv4YN3Y1yPcYTbOoBnImg8ngY+0okSYr6V+BQSKJWW73aYU3AR+a5eUoGom1G/lNkQIrs/5s1k5JzsN31+i7N/G8JNHhl54eJoHae3nvBUxu1it7qQs1svVHwd95PyA/sTu4gJKmAtWSBTmO8XMv6hvRwC9v1KxTBw/hd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548916; c=relaxed/simple;
	bh=0s4KTut5czTmGvdpV+MzgY6kPDZ9kI4CBltValqjD+8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DJtZHfqikkkHy/k5xeEBrr17eLMva8P6PezBzQj4lJ11QEALBtSsmFdtJhmsox1zeP0xPZj5Os215EAyblTVHTmWQtWUEtpUExMwHjxYSi2/KOzw6U+AHHkN3vrX3lES3hR4BG2Q8ST2a6odkke1UEkmPEHdImEs+2VR0k9nWcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Iv4eVcgo; arc=fail smtp.client-ip=40.93.194.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Iv4eVcgo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdguEDAynEIgN2qf+LZ20t78/vOCLxyh742y1Veq4hYAqpTBHZvG3ZSmna77W0wZ07+oGrWWGw3lN7GejvFslptDXCo0bWpuxk7Bi3m6awinIaZdBkJ0hxoJ9tAvmqPRTvAQ6NE/NG9qMU/ZJmQqQIouQVC6nhqP0XjVYxDVW/PyHToxYbGT241YGjI+bWbvIiiwibzQuMb2wkK4PvPJm95pqjdc3u6k3JQyhBsvIjbmpvGJ4Q+RYUKRqpHcue4Dg/ygATvhXhK4MDtSz+32Ylam/aOmhQSAaUjd2rRz6B6B1GMwHn1E1jghJnVbLvIYugeBrmXqneqksGy8sLeM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLPDMkWHUMUYlHTdX0A/tUtcXzX0G8xLslao3tboyJg=;
 b=IS3WSjzVocMMFeqALQWrjgqRd7djPJkaf8zXFMYzuzUQ2PRKm3O3L0P14YnqjoSs/1jjaOYit8IEZPbL0c3ta2FoT3LEJokXJQwPwWLh9X/cn3Xr2xEZMuWpl7tLpwjbhCAXyZYWJjxdkE+XDdlOGCKjztAWIANMQsKThsqCQ8ogU5XDvSPkpB2WOA9dT881CUNAMmiNHkfkttyrzQTFqj1wH+Y4xGQE5/TvZHU/aQhodr4U07RzZhzq5potHbaPnZVbOwTs+OO/zR08RP2TtP/90GFqSomOmGd2ris9Wzf3Y5k8VxXu77w9qE6Ww5k1ukP0pWRQR5REDeohJM/agg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLPDMkWHUMUYlHTdX0A/tUtcXzX0G8xLslao3tboyJg=;
 b=Iv4eVcgo/NCYBPHsYLrdYtf4HR/8wgMGR/Jg/ZmDW7gMrGiD2+n4GAT0jLqdD5GNx5AVL7cDdXSeLeA6Zgn8cso0B30jbDSZtcv+Si1aSHSwjcTvDIyLiVCMsLrdpfH5x60eXA2LrjZEGaaEjBOqcSS3TURTHq+ZMyYZtFRprG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 08:01:51 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 08:01:50 +0000
Message-ID: <827a6fdf-b119-4aea-9442-7f27f1383c78@amd.com>
Date: Tue, 7 Apr 2026 10:01:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: zynq-qspi: Simplify clock handling with
 devm_clk_get_enabled()
To: Pei Xiao <xiaopei01@kylinos.cn>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 broonie@kernel.org
References: <0c851587c90ae51d1498d18955aefc83fa41f17d.1775547057.git.xiaopei01@kylinos.cn>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <0c851587c90ae51d1498d18955aefc83fa41f17d.1775547057.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0463.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7f::7) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf14dba-49e0-433a-06ad-08de947beca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zHU3Gf2mD8mOKCV3j1gDQtEEiogzItcyQRgl8z876AK4tekZBdURbDsCj7bf7T32ppjK+HZNsHCHBw89MKZqaMqhqbNkXph+1ChbccneYuw7LZdK9FCqfXjI9xWVsbZqCXK4UCkqYfezU+wWOQB8lq9/ra56c1jSpphSo0TbFKH+AdYXD4aZP7SUqBjVx/v8eyr3ZBJPjEegWjfBHELyASjGUfu19tU7RAk846g0Sgncs/m7g9C8GsgAMQcn1X1S4Q147+AlM0++N7KsGuceX9UATvQ+nGgw+U7AE9bcH0eLlLN/SlUD4HM+cx+e5BRvuHjV1RvWATE/NcgxOww5ph8oxEFhkKZydVne9ubV9mqSWfLlwZQ2N1dyq3dkxh4Uoaq+PLSZVV+Zqg7hjc6ahjF/iYyWW67gFEa7N3WIUHxF1Oy8Zclm70NQWWsOdsYUSe3htoCf6B7pNFzDSNcGLP8EKoDUxZjRpowJhC8CeT91pzDA4u3EH58LOmJSARPY6YRlTYsEUWf3ZiAKIIVjCgsO/84fFaJZYIc/vB/cEWCdcTgNJHYEXP4EIa8fQJGgngZVxruDeZuDPs141Oe0VMt50t/UjuowO+vr7NbOQueUltkOV+BxBlGuX1qfuTTxjr9RFBnUpEgD6m54VbgZICg9nNap181qHrZ7O+mhye64I1ZPuMo0vX7K77U0OehS9c3JJwVNt2CTFg7u/4k3Ow2kwwTaX8Y02HD4XKIkkZw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WCtWTFI2TXB5MjhQZytHME1XcHI3b1d5aTBjcE5RaWliaFQrYXpDTlkrM0c4?=
 =?utf-8?B?VU9pRGFnd2dhOEFTcVhETWVReTZGRmhvWmJIMjR5SlZERFFSQmE4WUsvbUN4?=
 =?utf-8?B?UHN5UGpMNlJ2aXBvY1hhcERLZnJPZDJ3Vy9XMWQxSlh1dnZBYTFmVVlXTG1Y?=
 =?utf-8?B?b0wva3AweWJVaTFOY1BGa0dQQmJiSGN2encvWUQxUVB6QTRldG9ZdWt6emFC?=
 =?utf-8?B?YXlyMzF6R1JwenY2S29NMVd3Z0R5WS9QQ09XSlhFMGZXZm9iZUZFdEF4bWVO?=
 =?utf-8?B?M1p6dnc1OVRXbGJFRG9HcElGVnJqNVIyNmplK1pKbzRwcWlSOUZNMW5nenVw?=
 =?utf-8?B?MzFZM3BnWUlYSlY2TWVSZU1JMFA3Z25BVXZ5U001MEVLRTRxSmNQd21aQnhC?=
 =?utf-8?B?RS9xUE5pOGpnRS9FMGYxRWdma2ROb0EzN3B6azcxZVhlSTVEVHlrYytNVTN6?=
 =?utf-8?B?dzhtUHN4bDVyeS9aSkJlQUNPT1BSdzlxVlBtOEE1akVhbUJLaTFKMTJXejZU?=
 =?utf-8?B?VjR6OGpJcVA0R1RVYXJtTlFURHFSNGlJR05WQXRDRGhhUTE0R2VXdGppWmlx?=
 =?utf-8?B?cmNhWk1kOTkxSit5WnI3VXlnbDRSUFpHOTczUjlzaUJJWXovNWMvNDh5aERy?=
 =?utf-8?B?ak5yN3VWSjkrRllkNFU2YkwxYUxrck1NcXhya1NWSnR4NzVaNTUwZGE4SDNk?=
 =?utf-8?B?VmZPOEZRU1ZES1U4aVQzcVJ0YzNCWEYwM2d0NGcwRkFHR1JnR1RXTHh6OHNF?=
 =?utf-8?B?MWxoeXl5ZGxEUzA4S2EvMjBMeVJUZDJhZGxsMGJwUFJsNHFVNHViT1VEUXcz?=
 =?utf-8?B?QitTZ2xMQndERlR3anh0RXMzNWh6dUh4MUpJUGhEUkZTTzgrekZtZ0xpQm5E?=
 =?utf-8?B?Rk0vdnUwUkp1V2xKd0FGSGVhb1lLUDE5b0NCdElRS1dhOWNLWHgvR1lISVAw?=
 =?utf-8?B?NXBYQ1hSTWJqQ1JRa09ZV0lGWjl6Z1NialZlUkc3TWxUbVZnWFlFK3hOdzRC?=
 =?utf-8?B?d2RpOFowTHRMcS9wYXNSREs5WUQrcVFBbk92cUFVSGhndXJ0aUc0UkExSSsx?=
 =?utf-8?B?VVdFeUVjODRZSDQxUG4ycmNDNTIrd2J6TWt3eFNLckdXQWptckNzQVVQWWhG?=
 =?utf-8?B?WEY5RjV6RWZxWXZmYVdnZUwvUWJSSmxhSysveWc4a3RiQTVScFFYMHZqY1d6?=
 =?utf-8?B?SDFjYytveXZJb1I0QjFtV0E1VEdEYVhoUVB4WGI4MTlNRWE3UEhOUEpwRFRo?=
 =?utf-8?B?SEtiam9ObmhnV1k2aHcrUU8zR2VyWGFyOHdnNnFNSW52Sm51d0E0eDlZdm8r?=
 =?utf-8?B?VW9LZXFJQUU0NjlSbXVPYkdUelVXUjZXcFZPbTIxcGJZTGpacFBZOFpKVXZl?=
 =?utf-8?B?UGd2T1lkRnB5ay9XdThiYngrUFVrSjUrZHpxVDFQU2ZXOExCMTk2QzhPdFBD?=
 =?utf-8?B?Sng3Mi9pVTBrUFV2QTdyUVZiK1dGSHYvYjF0aVArK3ZvODBzZzlDc0JKNXRG?=
 =?utf-8?B?RmtyVFJHZ3VGbWRoeXFPOVNoc2RFcjBzZXVmOGN0cm1LcC9iUzN3K1lzVGpZ?=
 =?utf-8?B?WVVsLzRCT25ScndvdkNUZW16by9LNUZvZXJIem5UR3laZTZCM2Y5aXRWQUdT?=
 =?utf-8?B?V3A0d0UvMVZpQ1A1eGhFbGhPdG15dzhwUFFVWjFsWS81K0g4TTZWeFZQK2c3?=
 =?utf-8?B?U0VlUUpTLyt6dnFhdWtFMHE5M1FJS0cwSVJNbksrYVVzbzFDSzlteFJpcStX?=
 =?utf-8?B?cjNwb1pKMDN0cXVDblZ0TEZHeVg2cFRkbDhxdGxZSjU5eXM5akF6SmloZVU5?=
 =?utf-8?B?SnpYbWxnQUY0a3AxWkswVTArd0ZNdnJJT0FJbXBXNVNhVXMrRVc1K282eStI?=
 =?utf-8?B?bE5PUGZ3WGs3SjhYWmR4SnU3dzFNTXFna2I3R2dSY0dhY2piQTMvWHVWMGJ0?=
 =?utf-8?B?YXA2VEJiOXJ5RjFLMTRXR2NqdVlhQlFpdURoT29mZlJTMVpTNE9PaXJ3Smcv?=
 =?utf-8?B?d0h3M25sdmlONnBiVmt2U2FrbUxGOXJRTmdKMlMvKzV3YUhsK1NTN1VoL09M?=
 =?utf-8?B?NEN0d3JnditkSUszemoxaUhLQ1dvK25XT2FyZG94bEk5aDRFcVg0dFFiSzBE?=
 =?utf-8?B?dlkveGJXQTZaZEFIbVdyN3FMd3FKMTE4ZXlGOE5nNmFVT2VqY2tHV0NaQzNC?=
 =?utf-8?B?QjU0SnNRTHVNZy9aemR0TDJyWm9HY3FoWFhoYkZGR05kMGR6dklrQnYvYTN3?=
 =?utf-8?B?Y1h3by9nSVZPNnpnZS9ha3JUdzE0RExnWU5LaHJualc1endQUUlYcnZzQVZt?=
 =?utf-8?B?bXNXQURoQXUrTXVyeUxvT2w5OEFWRXFFQTBIbVc2RlRGaUZDMy9XUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf14dba-49e0-433a-06ad-08de947beca6
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 08:01:50.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuyTM3CefEQO3f2RdJ3S/oERcVqC6nudTc1LhSrcYoAsvObYeceAYWgNDe3Mbrgv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748



On 4/7/26 09:32, Pei Xiao wrote:
> [You don't often get email from xiaopei01@kylinos.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for both "pclk" and "ref_clk". This removes
> the need for explicit clock enable and disable calls, as the managed
> API automatically disables the clocks on device removal or probe
> failure.
> 
> Remove the now-unnecessary clk_disable_unprepare() calls from the
> probe error paths and the remove callback. Simplify error handling
> by jumping directly to the remove_ctlr label.
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>   drivers/spi/spi-zynq-qspi.c | 31 ++++++-------------------------
>   1 file changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
> index 5232483c4a3a..8c3975030d0a 100644
> --- a/drivers/spi/spi-zynq-qspi.c
> +++ b/drivers/spi/spi-zynq-qspi.c
> @@ -661,7 +661,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>                  goto remove_ctlr;
>          }
> 
> -       xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
> +       xqspi->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
>          if (IS_ERR(xqspi->pclk)) {
>                  dev_err(&pdev->dev, "pclk clock not found.\n");
>                  ret = PTR_ERR(xqspi->pclk);
> @@ -670,36 +670,24 @@ static int zynq_qspi_probe(struct platform_device *pdev)
> 
>          init_completion(&xqspi->data_completion);
> 
> -       xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
> +       xqspi->refclk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
>          if (IS_ERR(xqspi->refclk)) {
>                  dev_err(&pdev->dev, "ref_clk clock not found.\n");
>                  ret = PTR_ERR(xqspi->refclk);
>                  goto remove_ctlr;
>          }
> 
> -       ret = clk_prepare_enable(xqspi->pclk);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Unable to enable APB clock.\n");
> -               goto remove_ctlr;
> -       }
> -
> -       ret = clk_prepare_enable(xqspi->refclk);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Unable to enable device clock.\n");
> -               goto clk_dis_pclk;
> -       }
> -
>          xqspi->irq = platform_get_irq(pdev, 0);
>          if (xqspi->irq < 0) {
>                  ret = xqspi->irq;
> -               goto clk_dis_all;
> +               goto remove_ctlr;
>          }
>          ret = devm_request_irq(&pdev->dev, xqspi->irq, zynq_qspi_irq,
>                                 0, pdev->name, xqspi);
>          if (ret != 0) {
>                  ret = -ENXIO;
>                  dev_err(&pdev->dev, "request_irq failed\n");
> -               goto clk_dis_all;
> +               goto remove_ctlr;
>          }
> 
>          ret = of_property_read_u32(np, "num-cs",
> @@ -709,7 +697,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>          } else if (num_cs > ZYNQ_QSPI_MAX_NUM_CS) {
>                  ret = -EINVAL;
>                  dev_err(&pdev->dev, "only 2 chip selects are available\n");
> -               goto clk_dis_all;
> +               goto remove_ctlr;
>          } else {
>                  ctlr->num_chipselect = num_cs;
>          }
> @@ -728,15 +716,11 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>          ret = devm_spi_register_controller(&pdev->dev, ctlr);
>          if (ret) {
>                  dev_err(&pdev->dev, "devm_spi_register_controller failed\n");
> -               goto clk_dis_all;
> +               goto remove_ctlr;
>          }
> 
>          return ret;
> 
> -clk_dis_all:
> -       clk_disable_unprepare(xqspi->refclk);
> -clk_dis_pclk:
> -       clk_disable_unprepare(xqspi->pclk);
>   remove_ctlr:
>          spi_controller_put(ctlr);
> 
> @@ -758,9 +742,6 @@ static void zynq_qspi_remove(struct platform_device *pdev)
>          struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
> 
>          zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET, 0);
> -
> -       clk_disable_unprepare(xqspi->refclk);
> -       clk_disable_unprepare(xqspi->pclk);
>   }
> 
>   static const struct of_device_id zynq_qspi_of_match[] = {
> --
> 2.25.1
> 

There is also clock manipulation in zynq_qspi_setup_op() which needs to be handled.

Thanks,
Michal


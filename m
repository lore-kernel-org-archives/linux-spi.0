From: Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [RESEND PATCH 1/2] mtd: spi-nor: add macros related to MICRON
 flash
Date: Thu, 20 Sep 2018 12:20:15 +0300
Message-ID: <2f7430c2-bef0-0959-e428-ea1658cb9818@microchip.com>
References: <1537332608-19561-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537332608-19561-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <bd92d56c-fba6-6b79-07a8-cb426de33639@microchip.com>
 <VI1PR04MB103873DF92DF3380E53C572699130@VI1PR04MB1038.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB103873DF92DF3380E53C572699130@VI1PR04MB1038.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


>>> diff --git a/drivers/mtd/spi-nor/spi-nor.c
>>> @@ -271,6 +271,7 @@ static inline int set_4byte(struct spi_nor *nor, const
>> struct flash_info *info,
>>>  	u8 cmd;
>>>
>>>  	switch (JEDEC_MFR(info)) {
>>> +	case SNOR_MFR_ST:
>>
>> We should mark switch cases where we are expecting to fall through, so that we
>> will be prepared when enabling -Wimplicit-fallthrough.
> 
> Please explain more, not able to get this comment. Sorry for ignorance.
> 
>>
>>>  	case SNOR_MFR_MICRON:
>>>  		/* Some Micron need WREN command; all will accept it */
>>>  		need_wren = true;

We can ignore my comment, it's not in the scope of this patch.

I wrongly suggested to do this:
case SNOR_MFR_ST:
	/* fall through */
case SNOR_MFR_MICRON:

in order to suppress the -Wimplicit-fallthrough warning that I thought it will
appear on gcc 7. The suggestion is wrong because the warning is not emitted for
empty case bodies, so it's not needed here.

However, when compiling with gcc 7 and -Wimplicit-fallthrough the following can
be seen:

drivers/mtd/spi-nor/spi-nor.c: In function ‘set_4byte’:
drivers/mtd/spi-nor/spi-nor.c:290:13: warning: this statement may fall through
[-Wimplicit-fallthrough=]
   need_wren = true;
   ~~~~~~~~~~^~~~~~
drivers/mtd/spi-nor/spi-nor.c:291:2: note: here
  case SNOR_MFR_MACRONIX:
  ^~~~

We should add a /* fall through */ comment after setting need_wren = true;, but
it's not in the scope of this patch.

Cheers,
ta

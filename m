From: Michael Walle <michael@walle.cc>
Subject: Re: [EXT] [PATCH] spi: nxp-fspi: Ensure width is respected in spi-mem
 operations
Date: Tue, 07 Jan 2020 09:32:15 +0100
Message-ID: <650f957c95e2ee99db646fe620268ff9@walle.cc>
References: <20191211195730.26794-1-michael@walle.cc>
 <AM0PR0402MB3556E16D1027FB5D6C3FDC88E03F0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>
To: Kuldeep Singh <kuldeep.singh@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR0402MB3556E16D1027FB5D6C3FDC88E03F0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am 2020-01-07 06:39, schrieb Kuldeep Singh:
> Hi Michael,
> 
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
>> owner@vger.kernel.org> On Behalf Of Michael Walle
>> Sent: Thursday, December 12, 2019 1:28 AM
>> To: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>; Ashish Kumar
>> <ashish.kumar@nxp.com>; Mark Brown <broonie@kernel.org>; Michael
>> Walle <michael@walle.cc>
>> Subject: [EXT] [PATCH] spi: nxp-fspi: Ensure width is respected in 
>> spi-mem
>> operations
>> 
>> Caution: EXT Email
>> 
>> Make use of a core helper to ensure the desired width is respected 
>> when
>> calling spi-mem operators.
>> 
>> Otherwise only the SPI controller will be matched with the flash chip, 
>> which
>> might lead to wrong widths. Also consider the width specified by the 
>> user in
>> the device tree.
> 
> Could you please mention the flash and modes you tested. Does it
> support DUAL/QUAD mode?
> I couldn't test these modes as NXP LS1028ARDB has "mt35xu02g" which
> supports SINGLE and OCTAL modes only.

That commit is already upstream. But FWIW, it was a Winbond W25Q32FW in 
dual i/o mode.

-michael

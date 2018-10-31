From: Schrempf Frieder <frieder.schrempf@kontron.De>
Subject: Re: [PATCH v2 00/12] Port the FSL QSPI driver to the SPI framework
Date: Wed, 31 Oct 2018 16:09:29 +0000
Message-ID: <02902fad-8c60-49a0-34d6-5bbf4ef38fd9@kontron.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <20181031144055.32e1c8f1@bbrezillon>
 <dd4b9af1-82f3-469e-e70f-2858e85a5dfe@kontron.de>
 <20181031153125.3c5dfca1@bbrezillon>
 <VI1PR04MB57265EAA4010079B6194367599CD0@VI1PR04MB5726.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "richard@nod.at" <richard@nod.at>,
 Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, Han Xu <han.xu@nxp.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, David Wolfe <david.wolfe@nxp.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, Boris Brezillon
 <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <VI1PR04MB57265EAA4010079B6194367599CD0@VI1PR04MB5726.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-ID: <E9C1E1AA7FEE384A9C706B243643902F@snt-world.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Yogesh,

On 31.10.18 17:03, Yogesh Narayan Gaur wrote:
> Hi Frieder,
> 
>> -----Original Message-----
>> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
>> Sent: Wednesday, October 31, 2018 8:01 PM
>> To: Schrempf Frieder <frieder.schrempf@kontron.De>
>> Cc: linux-mtd@lists.infradead.org; linux-spi@vger.kernel.org;
>> dwmw2@infradead.org; computersforpeace@gmail.com;
>> marek.vasut@gmail.com; richard@nod.at; miquel.raynal@bootlin.com;
>> broonie@kernel.org; David Wolfe <david.wolfe@nxp.com>; Fabio Estevam
>> <fabio.estevam@nxp.com>; Prabhakar Kushwaha
>> <prabhakar.kushwaha@nxp.com>; Yogesh Narayan Gaur
>> <yogeshnarayan.gaur@nxp.com>; Han Xu <han.xu@nxp.com>;
>> shawnguo@kernel.org
>> Subject: Re: [PATCH v2 00/12] Port the FSL QSPI driver to the SPI framework
>>
>> On Wed, 31 Oct 2018 13:54:29 +0000
>> Schrempf Frieder <frieder.schrempf@kontron.De> wrote:
>>
>>> Hi Boris,
>>>
>>> On 31.10.18 14:40, Boris Brezillon wrote:
>>>> Hi Frieder, Yogesh,
>>>>
>>>> On Thu,  5 Jul 2018 13:14:56 +0200
>>>> Frieder Schrempf <frieder.schrempf@exceet.de> wrote:
>>>>
>>>>> Now that the SPI memory interface was introduced by Boris [1], it
>>>>> is possible to move drivers from mtd/spi-nor to the SPI framework
>>>>> in order to use them for different type of SPI memory chips.
>>>>>
>>>>> Patch 1 adds a function spi_mem_get_name() to the SPI memory
>>>>> interface and a ->name field to struct spi_mem.
>>>>> Patch 2 uses it in m25p80.c to make it possible for SPI controller
>>>>> drivers to provide a custom naming scheme for the flash chip.
>>>>> This is needed to avoid breaking compatibility of mtdparts when
>>>>> switching from the old to the new driver.
>>>>>
>>>>> Patch 3 adds a driver for the Freescale QSPI controller to the SPI
>>>>> framework. Together with m25p80.c it can be used to interface SPI
>>>>> NOR flashes just as the old driver did. For this to work properly a
>>>>> few minor changes to the devicetrees are necessary (see patches 5 to 7).
>>>>>
>>>>> Patch 8 changes the defconfigs to use the new driver and patch 9
>>>>> removes the old driver.
>>>>>
>>>>> Patch 10 and 11 remove 'fsl,qspi-has-second-chip' from the devicetrees.
>>>>> Patch 12 adjusts the MAINTAINERS file.
>>>>>
>>>>> The new driver was tested with i.MX6UL and a Micron SPI NOR @ 60MHz.
>>>>> The read performance of the new driver is almost the same or even
>>>>> better than the old driver, depending on the block size.
>>>>> The write performance is a bit slower on average (~10-15%).
>>>>>
>>>>> The new driver was also tested with the SPI NAND framework [2] and
>>>>> a Winbond W25M02GV flash.
>>>>>
>>>>> If someone has a board that uses both chips selects and/or both
>>>>> busses, it would be really nice to have the driver be tested on such a setup.
>>>>
>>>> Any progress on this front? Yogesh, can you please remind us the
>>>> remaining issues? I'd really like to make some progress, otherwise
>>>> the conversion to spi-mem will take ages.
>>>
>>> I definitely want to continue this. I just did not have the time to
>>> work on it.
>>>
>>> I think the only remaining blocking issues is the one that Yogesh
>>> reported while testing with two chips on the same bus.
>>
>> Maybe you can send a new version rebased on v4.20-rc1 (when it's out) and
>> push it somewhere so that Yogesh can test it (again).
> In next version, please take care of the comments being raised by Boris in NXP FlexSPI controller driver patch series. E.g.
> 1. Redefine all mask fields and use BIT(X) for single bit set/unset.
> 2. Remove function pointer hooks for ->read/->write function.
> 3. Remove dependency from 'endianess' property from DTS node.
> 4. Usage of readl_poll_timeout() instead of busy looping.

Thanks for reminding me. I have these on my list.

Thanks,
Frieder

> 
> --
> Regards
> Yogesh Gaur
> 
>   Yogesh, can we please
>> make some progress on this? If you really have a bug, that'd be great to have a
>> serious investigation on what is causing this bug. The explanation we had so far
>> were not really helpful in understanding the problem.
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

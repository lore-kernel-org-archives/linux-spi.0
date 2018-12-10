From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Date: Mon, 10 Dec 2018 11:50:01 +0100
Message-ID: <20181210115001.6c7af1d7@bbrezillon>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1542366701-16065-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <eb8a31d8-2ba6-f27c-addf-545c77921b77@kontron.de>
        <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181210111909.35384eee@bbrezillon>
        <VI1PR04MB57268740CA806FFB164780EB99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Schrempf Frieder <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB57268740CA806FFB164780EB99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 10 Dec 2018 10:43:56 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > > Thus, in LUT preparation we have assigned only the base address.
> > > Now if I have assigned ahb_buf_size to FSPI_FLSHXXCR0 register then for  
> > read/write data beyond limit of ahb_buf_size offset I get data corruption.
> > 
> > Why would you do that? We have the ->adjust_op_size() exactly for this reason,
> > so, if someone tries to do a spi_mem_op with data.nbytes > ahb_buf_size you
> > should return an error.
> >   
> Let me explain my implementation with example. If I have to write data of size 0x100 bytes at offset 0x1200 for CS1, I would program as below:
> In func nxp_fspi_select_mem(), would set value of controller address space size, memmap_phy_size, to FSPI_FLSHA2CR0 and rest all FSPI_FLSHXXCR0 as 0. 
> Value of memmap_phy_size is 0x10000000 i.e. 256 MB for my LX2160ARDB target.
> Then in nxp_fspi_prepare_lut(), I would prepare LUT ADDR with address length requirement 3/4 byte for NOR or 1/2/3/4 bytes for NAND flash.
> Also for LUT_NXP_WRITE would program data bytes as 0.
> 
> Then inside func nxp_fspi_do_op(), set register FSPI_IPCR0 as the address offset i.e. 0x1200 and in register FSPI_IPCR1 program the data size to write i.e. 0x100
> 
> If, as suggested if I tries to mark value of register FSPI_FLSHA2CR0 equal to ahb_buf_size (0x800), then access for address 0x1200 gives me wrong data. This is because as per the controller specification access to flash connected at CS1 can be performed under range of FSPI_ FLSHA1CR0 and FSPI_ FLSHA2CR0.

Don't you have a way to set an offset to apply to the address accessed
through the AHB? And if you don't, how will it work if your mapping
is smaller than the flash size?

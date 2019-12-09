From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/4] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
Date: Mon, 9 Dec 2019 15:23:27 +0530
Message-ID: <20f3873f-66eb-3af9-c50d-1321a859093d@ti.com>
References: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
 <1573808288-19365-3-git-send-email-masonccyang@mxic.com.tw>
 <3f514579-d3a4-1319-a55a-265a3f1ce00e@ti.com>
 <OFFE6363DF.95763BC3-ON482584CB.002A47E5-482584CB.002BAA8C@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: tudor.ambarus@microchip.com, juliensu@mxic.com.tw, richard@nod.at,
 bbrezillon@kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 marek.vasut@gmail.com, broonie@kernel.org, linux-mtd@lists.infradead.org,
 miquel.raynal@bootlin.com, computersforpeace@gmail.com, dwmw2@infradead.org
To: <masonccyang@mxic.com.tw>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <OFFE6363DF.95763BC3-ON482584CB.002A47E5-482584CB.002BAA8C@mxic.com.tw>
Content-Language: en-US
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

Hi,

On 09/12/19 1:26 pm, masonccyang@mxic.com.tw wrote:
> 
> Hi Vignesh,
> 
>>
>> On 15/11/19 2:28 pm, Mason Yang wrote:
>>> According to JESD216C (JEDEC Basic Flash Parameter Table 18th DWORD)
>>> Octal DTR(8D-8D-8D) command and command extension (00b: same, 01b: 
> inverse)
>>> to add extension command mode in spi_nor struct and to add write_cr2
>>> (Write CFG Reg 2) for 8-8-8/8D-8D-8D mode sequences enable.
>>>
>>
>> But I don't see any code setting "nor->ext_cmd_mode" based on BFPT?
>>
>> Any new feature that we add to spi-nor should make use of autodiscovery
>> feature made possible by SFDP tables. Could you modify the patch to
>> discover capabilities supported by flash and opcodes to be used from
>> SFDP table?
> 
> Got it but our device will return a empty SFDP table.
> 

If flash you tested on does not support JEDEC 216C then don't mention
about it. Above commit message gives an impression that flash in JEDEC
216C compliant.

>>
>>
>>> Define the relevant macrons and enum to add such modes and make sure
>>> op->xxx.dtr fields, command nbytes and extension command are properly
>>> filled and unmask DTR and X-X-X modes in 
> spi_nor_spimem_adjust_hwcaps()
>>> so that DTR and X-X-X support detection is done through
>>> spi_mem_supports_op().
>>>
[...]
>>> @@ -404,6 +436,30 @@ static int read_sr(struct spi_nor *nor)
>>>                 SPI_MEM_OP_NO_DUMMY,
>>>                 SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
>>>
>>
>> This is not based on the latest tree.
>>
>>> +      if (spi_nor_protocol_is_8_8_8(nor->read_proto)) {
>>> +         op.cmd.buswidth = 8;
>>> +         op.addr.buswidth = 8;
>>> +         op.dummy.buswidth = 8;
>>> +         op.data.buswidth = 8;
>>> +         op.cmd.nbytes = 2;
>>> +         op.addr.nbytes = 4;
>>> +         op.dummy.nbytes = 4;
>>> +         op.addr.val = 0;
>>
>> This is not scalable... There will be bunch of if...else ladders when we
>> want to support other X-X-X modes... Can't these be derived from
>> nor->reg_proto? And then borrow the logic from 
> spi_nor_spimem_read_data()?
>>
> 
> Got it !
> 
>>
>> Could you have a look at Boris's initial submission to add 8-8-8 mode at
>> https://patchwork.kernel.org/cover/10638055/ ?
>> You could use that series as the base for your changes/additions.
> 
> Got it.
> My idea is to support 8D-8D-8D mode with a minimum patches because 
> there is no define for 1D-1D-1D, 2D-2D-2D and 4D-4D-4D mode in JEDEC 
> if I am right.
> 

JESD251-A1 does talk about 4S-4D-4D right? Also none of the JEDEC
standards prohibit flash vendors from supporting other X-X-X modes.

I think you haven't thought about bigger picture here. Flash devices
that support other mode exist today and we would need the framework to
be built such that these modes can be added in future.

I suggest you start with Boris's series [1] as base and port it to
latest kernel. Isn't that series alone enough to support Macronix Octal
flashes at least?
If required, you could also always include additional patches adding new
features.

[1] https://patchwork.kernel.org/cover/10638055/

-- 
Regards
Vignesh

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

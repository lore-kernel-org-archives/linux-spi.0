From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v12 2/4] mtd: spi-nor: add spi-mem support in
 cadence-quadspi controller driver
Date: Thu, 19 Mar 2020 15:00:24 +0530
Message-ID: <cea89434-d2bf-72e6-0b3b-0e0efd0d149e@ti.com>
References: <20200310015213.1734-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200310015213.1734-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <3360641.Vn3sISamPi@192.168.0.120>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: marex@denx.de, devicetree@vger.kernel.org, tien.fong.chee@intel.com,
 tudor.ambarus@gmail.com, boris.brezillon@free-electrons.com,
 computersforpeace@gmail.com, richard@nod.at, simon.k.r.goldschmidt@gmail.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
 dinguyen@kernel.org, broonie@kernel.org, miquel.raynal@bootlin.com,
 cheol.yong.kim@intel.com, cyrille.pitchen@atmel.com, qi-ming.wu@intel.com,
 dwmw2@infradead.org, david.oberhollenzer@sigma-star.at
To: <Tudor.Ambarus@microchip.com>, <linux-mtd@lists.infradead.org>,
 <vadivel.muruganx.ramuthevar@linux.intel.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <3360641.Vn3sISamPi@192.168.0.120>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org



On 19/03/20 1:39 pm, Tudor.Ambarus@microchip.com wrote:
> Hi,
> 
> On Tuesday, March 10, 2020 3:52:11 AM EET Ramuthevar, Vadivel MuruganX wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
>> content is safe
>>
>> From: Ramuthevar Vadivel Murugan
>> <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> This patch adds a spi-mem framework adaptation over cadence-quadspi driver.
> 
> you need to specify on which versions of the controller you tested this.
> 
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan
>> <vadivel.muruganx.ramuthevar@linux.intel.com> Signed-off-by: Vignesh
>> Raghavendra <vigneshr@ti.com>
>> ---
>>  drivers/mtd/spi-nor/cadence-quadspi.c | 538
>> +++++++++++++--------------------- 1 file changed, 209 insertions(+), 329
>> deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c
>> b/drivers/mtd/spi-nor/cadence-quadspi.c index 494dcab4aaaa..7b52e109036e
>> 100644
>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>> @@ -3,6 +3,8 @@
> 
> cut
> 
>>  struct cqspi_st {
>> @@ -70,23 +66,20 @@ struct cqspi_st {
>>         void __iomem            *ahb_base;
>>         resource_size_t         ahb_size;
>>         struct completion       transfer_complete;
>> -       struct mutex            bus_mutex;
> 
> are we now supporting just a single flash on the bus? Does 
> CQSPI_MAX_CHIPSELECT make sense anymore?
> 

Driver still supports multiple CS but SPI core takes care of
serialization by holding bus_lock_mutex in spi_mem_access_start()

So, I don't see a need for this mutex

[...]

> 
> cut
> 
>> -static int cqspi_of_get_pdata(struct platform_device *pdev)
>> +static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
>>  {
>> -       struct device_node *np = pdev->dev.of_node;
>> -       struct cqspi_st *cqspi = platform_get_drvdata(pdev);
>> -
>> -       cqspi->is_decoded_cs = of_property_read_bool(np,
>> "cdns,is-decoded-cs"); +       struct device *dev = &cqspi->pdev->dev;
> 
> you dropped the reading of this property, but you kept the is_decoded_cs 
> member, shouldn't you drop the latter too? I guess this deserves a dedicated 
> patch.
> 

is_decoded_cs cannot be supported with spi-mem as this requires
knowlegde of flash geometry which is not available via spi-mem

I don't see any user of decoded-cs in the kernel. So, IMO its okay to
drop entire support in a patch prior to converting driver to spi-mem.

[...]

>> @@ -1423,16 +1295,28 @@ static int cqspi_probe(struct platform_device *pdev)
>> cqspi->current_cs = -1;
>>         cqspi->sclk = 0;
>>
>> -       ret = cqspi_setup_flash(cqspi, np);
>> +       ret = cqspi_setup_flash(cqspi);
>>         if (ret) {
>> -               dev_err(dev, "Cadence QSPI NOR probe failed %d\n", ret);
>> +               dev_err(dev, "failed to setup flash parameters %d\n", ret);
>>                 goto probe_setup_failed;
>>         }
>>
>> -       return ret;
>> +       if (cqspi->use_dac_mode) {
>> +               ret = cqspi_request_mmap_dma(cqspi);
> 
> the driver was requesting the mmap for each available flash and now you do it 
> once, which is great, but this too has to be made in a dedicated patch.
>

Not really, current driver does:

                        if (!cqspi->rx_chan)
                                cqspi_request_mmap_dma(cqspi);

So, cqspi_request_mmap_dma() is not called again if it succeeds for at
least one flash.

Regards
Vignesh

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

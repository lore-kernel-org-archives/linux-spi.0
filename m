From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v3 03/13] spi: atmel-quadspi: drop wrappers for iomem
 accesses
Date: Sat, 2 Feb 2019 08:44:27 +0000
Message-ID: <53c9f4b2-7022-e13d-65a4-2e1bed4d76b1@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-4-tudor.ambarus@microchip.com>
 <20190202081111.0bbc4443@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Ludovic.Desroches@microchip.com, Cyrille.Pitchen@microchip.com,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: <bbrezillon@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190202081111.0bbc4443@bbrezillon>
Content-Language: en-US
Content-ID: <DCD794DE2C183345BDE83BB586E8540E@namprd11.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org



On 02/02/2019 09:11 AM, Boris Brezillon wrote:
> On Sat, 2 Feb 2019 04:07:19 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> The wrappers hid that the accesses are relaxed. Drop them.
>>
>> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>> v3: no change
>> v2: new patch
>>
>>  drivers/spi/atmel-quadspi.c | 47 +++++++++++++++++++--------------------------
>>  1 file changed, 20 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
>> index feeddcb25e1f..131374db0db4 100644
>> --- a/drivers/spi/atmel-quadspi.c
>> +++ b/drivers/spi/atmel-quadspi.c
>> @@ -175,17 +175,6 @@ static const struct qspi_mode sama5d2_qspi_modes[] = {
>>  	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
>>  };
>>  
>> -/* Register access functions */
>> -static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
>> -{
>> -	return readl_relaxed(aq->regs + reg);
>> -}
>> -
>> -static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
>> -{
>> -	writel_relaxed(value, aq->regs + reg);
>> -}
>> -
>>  static inline bool is_compatible(const struct spi_mem_op *op,
>>  				 const struct qspi_mode *mode)
>>  {
>> @@ -229,6 +218,7 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
>>  static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>  {
>>  	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
>> +	void __iomem *base = aq->regs;
> 
> Can we name this variable regs instead of base or even get rid of it
> and dereference aq->regs in the xxx_relaxed() calls (doesn't look like
> the lines would be over 80 chars even when doing that). With this
> addressed, you can add:
> 
> Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

I chose to introduce the "base" variable when I have at least 2 dereferences in
a function, as an optimization. In exec_op() for example, there are 6
dereferences of aq->reqs. Why do you prefer keeping aq->regs?

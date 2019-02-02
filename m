From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v3 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Date: Sat, 2 Feb 2019 08:38:40 +0000
Message-ID: <adf1d099-b8fd-6f91-75d7-6eee256b470b@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-2-tudor.ambarus@microchip.com>
 <20190202080650.44becc2d@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
 Ludovic.Desroches@microchip.com, Cyrille.Pitchen@microchip.com,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-arm-kernel@lists.infradead.org
To: <bbrezillon@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190202080650.44becc2d@bbrezillon>
Content-Language: en-US
Content-ID: <5481712A5D9E7D4CB4C58E8754D3914A@namprd11.prod.outlook.com>
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



On 02/02/2019 09:06 AM, Boris Brezillon wrote:
> On Sat, 2 Feb 2019 04:07:13 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> Cache Serial Memory Mode (SMM) value to avoid write access when
>> setting the controller in serial memory mode. SMM is set in
>> exec_op() and not at probe time, to let room for future regular
>> SPI support.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>> v3: update smm value when different. rename mr/smm
>> v2: cache MR value instead of moving the write access at probe
>>
>>  drivers/spi/atmel-quadspi.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
>> index ddc712410812..645284c6ec9a 100644
>> --- a/drivers/spi/atmel-quadspi.c
>> +++ b/drivers/spi/atmel-quadspi.c
>> @@ -155,6 +155,7 @@ struct atmel_qspi {
>>  	struct clk		*clk;
>>  	struct platform_device	*pdev;
>>  	u32			pending;
>> +	u32			smm;
>>  	struct completion	cmd_completion;
>>  };
>>  
>> @@ -238,7 +239,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>  	icr = QSPI_ICR_INST(op->cmd.opcode);
>>  	ifr = QSPI_IFR_INSTEN;
>>  
>> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
>> +	/* Set the QSPI controller in Serial Memory Mode */
>> +	if (aq->smm != QSPI_MR_SMM) {
> 
> Sorry, I think I misunderstood your previous suggestion, I thought the
> reg was called SMM. If the reg is called MR and the value you expect in
> there is SMM, then the field should be named ->mr as it caches the
> whole reg, not only the SMM bit. So it's actually:
> 
> 	if (aq->mr != QSPI_MR_SMM) {

No worries. When keeping the reg name, and not the bit itself, I would expect to
do the check as in v2, to let room for checking other bits too:

+	if (!(aq->mr & QSPI_MR_SMM))

I don't have any problems to keep "mr" name, but I would like to understand your
reasons.

Thanks,
ta

> 
>> +		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
>> +		aq->smm = QSPI_MR_SMM;
>> +	}
>>  
>>  	mode = find_mode(op);
>>  	if (mode < 0)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

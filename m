From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [RFC PATCH 2/2] spi: spi-mem: Add support for Zynq QSPI controller
Date: Fri, 8 Mar 2019 10:20:19 +0530
Message-ID: <602dd5ed-48b6-2098-fc2a-e36192b6a8e7@ti.com>
References: <1551337361-11665-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <48dafcc4-1b9d-9ce2-9228-78e73252781f@ti.com>
 <MWHPR02MB262310CF8152AE170FE7443CAF760@MWHPR02MB2623.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "richard@nod.at" <richard@nod.at>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
 Michal Simek <michals@xilinx.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>
To: Naga Sureshkumar Relli <nagasure@xilinx.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "bbrezillon@kernel.org" <bbrezillon@kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <MWHPR02MB262310CF8152AE170FE7443CAF760@MWHPR02MB2623.namprd02.prod.outlook.com>
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



On 01/03/19 4:32 PM, Naga Sureshkumar Relli wrote:
>>> +static bool zynq_qspi_supports_op(struct spi_mem *mem,
>>> +				  const struct spi_mem_op *op)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = zynq_qspi_check_buswidth(op->cmd.buswidth);
>>> +
>>> +	if (op->addr.nbytes)
>>> +		ret |= zynq_qspi_check_buswidth(op->addr.buswidth);
>>> +
>>> +	if (op->dummy.nbytes)
>>> +		ret |= zynq_qspi_check_buswidth(op->dummy.buswidth);
>>> +
>>> +	if (op->data.nbytes)
>>> +		ret |= zynq_qspi_check_buswidth(op->data.buswidth);
>>> +
>>> +	if (ret)
>>> +		return false;
>>> +
>> spi_mem_default_supports_op() already has this code.
>> Could you change, spi_mem_supports_op() to call
>> spi_mem_default_supports_op() first before controller specific
>> ->supports_op()? So that, above code can be dropped.
> Ok, I will update it.
>>> +	/*
>>> +	 * The number of address bytes should be equal to or less than 3 bytes.
>>> +	 */
>>> +	if (op->addr.nbytes > 3)
>>> +		return false;
>>> +
>> Hmm, how does the driver handle flash devices >16MB in size? Not supported?
> Zynq QSPI controller doesn't support 4 byte addressing.
> So to support > 16MB size, we have to use EAR(extended address register).
> As it is initial version of driver, I haven't added this code. This needs to be added in spi-nor.c.
> Previously I have sent an RFC patch to support all these.
> But Boris suggested to upstream the basic one first under spi-mem frame work.
> Not only this support, there are other features like dual parallel and dual stacked.
> All these features require additional support from spi-nor framework.
> We have another QSPI controller on ZynqMP SOC, which is also similar(but it supports 4Byte addressing).
> So by consolidating all these, I sent this patch.
> 
> Please let me know your suggestion on this.

Sounds fine to me. Support for > 16MB flash using EAR can come later.

-- 
Regards
Vignesh

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

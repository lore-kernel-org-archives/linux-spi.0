From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Date: Tue, 18 Sep 2018 10:22:11 +0200
Message-ID: <9529c765-cb3b-02f9-df15-4f79cfa48e47@exceet.de>
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180917133751.453ea6ed@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, robh@kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, marek.vasut@gmail.com,
 linux-mtd@lists.infradead.org, computersforpeace@gmail.com,
 shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
To: Boris Brezillon <boris.brezillon@bootlin.com>,
 Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180917133751.453ea6ed@bbrezillon>
Content-Language: en-US
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

Hi Boris, Yogesh,

On 17.09.2018 13:37, Boris Brezillon wrote:
> Hi Yogesh,
> 
> On Mon, 17 Sep 2018 15:18:26 +0530
> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
>> +
>> +	/*
>> +	 * R/W functions for big- or little-endian registers:
>> +	 * The FSPI controller's endianness is independent of
>> +	 * the CPU core's endianness. So far, although the CPU
>> +	 * core is little-endian the FSPI controller can use
>> +	 * big-endian or little-endian.
>> +	 */
>> +	if (of_property_read_bool(np, "big-endian")) {
>> +		f->write = fspi_writel_be;
>> +		f->read = fspi_readl_be;
>> +	} else {
>> +		f->write = fspi_writel;
>> +		f->read = fspi_readl;
>> +	}
> 
> Hm, isn't it something you can extract from the compatible string? I'd
> rather not allow users to set that in their DT if it's not something
> you can change.

This was copied from the QSPI driver, but I think Boris is right. This 
seems to be a fixed SOC-specific setting and we shouldn't set it in the 
DT. This applies to QSPI and FSPI alike.

Regards,
Frieder

> 
> Regards,
> 
> Boris
> 

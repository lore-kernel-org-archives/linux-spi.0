From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Date: Thu, 31 Jan 2019 13:01:50 +0100
Message-ID: <20190131130137.52b592f8@bbrezillon>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-10-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190130150818.24902-10-tudor.ambarus@microchip.com>
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

On Wed, 30 Jan 2019 15:08:47 +0000
<Tudor.Ambarus@microchip.com> wrote:

> +/*
> + * atmel_qspi_set_address_mode() - set address mode.
> + * @cfg:	contains register values
> + * @op:		describes a SPI memory operation
> + *
> + * The controller allows 24 and 32-bit addressing while NAND-flash requires
> + * 16-bit long. Handling 8-bit long addresses is done using the option field.
> + * For the 16-bit addresses, the workaround depends of the number of requested
> + * dummy bits. If there are 8 or more dummy cycles, the address is shifted and
> + * sent with the first dummy byte. Otherwise opcode is disabled and the first
> + * byte of the address contains the command opcode (works only if the opcode and
> + * address use the same buswidth). The limitation is when the 16-bit address is
> + * used without enough dummy cycles and the opcode is using a different buswidth
> + * than the address.

Too bad they didn't patch the IP to support 1 to 4 address bytes
instead of only 3 or 4 :-(.

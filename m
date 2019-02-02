From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v3 08/13] spi: atmel-quadspi: drop unused and NOP
 transfer macros
Date: Sat, 2 Feb 2019 14:27:36 +0100
Message-ID: <20190202142736.5d723ed6@bbrezillon>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-9-tudor.ambarus@microchip.com>
 <20190202081338.01056dce@bbrezillon>
 <0e266a16-2f84-e1c3-440f-55105dd0c0be@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 Cyrille.Pitchen@microchip.com, robh+dt@kernel.org, linux-spi@vger.kernel.org,
 Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-arm-kernel@lists.infradead.org
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0e266a16-2f84-e1c3-440f-55105dd0c0be@microchip.com>
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

On Sat, 2 Feb 2019 08:46:38 +0000
<Tudor.Ambarus@microchip.com> wrote:

> On 02/02/2019 09:13 AM, Boris Brezillon wrote:
> > On Sat, 2 Feb 2019 04:07:33 +0000
> > <Tudor.Ambarus@microchip.com> wrote:
> >   
> >> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>
> >> Remove NOP when setting read transfer type. Remove useless
> >> setting of write transfer type when
> >> op->data.dir == SPI_MEM_DATA_IN && !op->data.nbytes.
> >>
> >> QSPI_IFR_TFRTYP_TRSFR_WRITE is specific just to sama5d2 qspi,
> >> rename it to QSPI_IFR_SAMA5D2_WRITE_TRSFR.
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >> v3: new patch
> >>
> >>  drivers/spi/atmel-quadspi.c | 12 +++---------
> >>  1 file changed, 3 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> >> index d26d4cd0e36b..bfa5f5e92d96 100644
> >> --- a/drivers/spi/atmel-quadspi.c
> >> +++ b/drivers/spi/atmel-quadspi.c
> >> @@ -113,11 +113,7 @@
> >>  #define QSPI_IFR_OPTL_4BIT              (2 << 8)
> >>  #define QSPI_IFR_OPTL_8BIT              (3 << 8)
> >>  #define QSPI_IFR_ADDRL                  BIT(10)
> >> -#define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
> >> -#define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
> >> -#define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
> >> -#define QSPI_IFR_TFRTYP_TRSFR_WRITE     (2 << 12)
> >> -#define QSPI_IFR_TFRTYP_TRSFR_WRITE_MEM (3 << 13)
> >> +#define QSPI_IFR_SAMA5D2_WRITE_TRSFR	BIT(13)  
> > 
> > Can you define QSPI_IFR_TFRTYP_MEM (bit 12) even if it's not used yet?  
> 
> Shouldn't be introduced with the dir map support?

I like when all regs/reg-fields are defined, even if they're not used.
In this case, you're cleary splitting the TFRTYP_TRSFR_ bitfields in 2:
one bit encoding the mem/reg transfer type and one bit encoding the
direction of the transfer (read/write). Just think it's better to add
bit 12 definition now.

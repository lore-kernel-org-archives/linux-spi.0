From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: Query: spi-nor: dummy buswidth calculation
Date: Tue, 4 Sep 2018 14:30:28 +0200
Message-ID: <20180904143028.4629fe10@bbrezillon>
References: <VI1PR04MB1038E10EBE458DD72A1070C499030@VI1PR04MB1038.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "juliensu@mxic.com.tw" <juliensu@mxic.com.tw>,
 "zhengxunli@mxic.com.tw" <zhengxunli@mxic.com.tw>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "masonccyang@mxic.com.tw" <masonccyang@mxic.com.tw>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <VI1PR04MB1038E10EBE458DD72A1070C499030@VI1PR04MB1038.eurprd04.prod.outlook.com>
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

+Macronix team

On Tue, 4 Sep 2018 09:28:11 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Boris,
> 
> I have query regarding dummy bus width calculation for the read commands, added in the patch series [1]
> 
> In func m25p80_read(), dummy.buswidth is being assigned as
> +       op.dummy.buswidth = op.addr.buswidth;
> 
> Above, buswidth for dummy commands are being assigned and are marked equal to the buswidth of the address command.
> This is true for case when we are doing operation in 1-4-4 or 1-2-2 protocol where data as well as address are running on same data lines and having same buswidth.
> 
> I am adding support of octal commands in framework and for this needs to add support for 1-1-8 protocol for Micron flash MT35XU512ABA1G12.
> For octal command, 7Ch, flash is sending data and the dummy on the 8 data lines and address on 1 data line.

Interesting. Macronix is also working on octo-mode support. I think we
should sync instead of duplicating the work.

> 
> If I do below code change, then I am getting correct data else there is data corruption only in the first byte read.
> -       op.dummy.buswidth = op.addr.buswidth;
> +       op.dummy.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);

Regarding this particular aspect, I just followed what was done before
the conversion to spi_mem_exec_op(). Maybe it was not correct though.

Regards,

Boris

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

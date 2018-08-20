From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] mtd: m25p80: consider max message size when use the
 spi_mem_xx() API
Date: Mon, 20 Aug 2018 15:54:51 +0200
Message-ID: <20180820155451.03d770eb@bbrezillon>
References: <1534769013-43449-1-git-send-email-chuanhua.han@nxp.com>
        <109aeb2622924f20b29743746bb77ce2@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: 'Chuanhua Han' <chuanhua.han@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "jiafei.pan@nxp.com" <jiafei.pan@nxp.com>,
        "zhiqiang.hou@nxp.com" <zhiqiang.hou@nxp.com>
To: David Laight <David.Laight@ACULAB.COM>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <109aeb2622924f20b29743746bb77ce2@AcuMS.aculab.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 20 Aug 2018 13:01:13 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Chuanhua Han
> > Sent: 20 August 2018 13:44
> > 

Still no message here, and the subject prefix is still wrong.


Fixes and Cc-stable tags should be placed here...

> > Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> > ---
> > Changes in v3:
> >     Rename variable name "val" to "opcode_addr_dummy_sum".
> >     Place the legitimacy of the transfer size(i.e., "pi_max_message_size(mem->spi)" and
> > "opcode_addr_dummy_sum") into "if (! ctlr - > mem_ops | |! ctlr-> mem_ops->exec_op) {"
> > structure and add "spi_max_transfer_size(mem->spi) and opcode_addr_dummy_sum".
> >     Adjust the formatting alignment of your code.
> >     "(unsigned long)op->data.nbytes" was modified to "(unsigned long)(op->data.nbytes)".
> > 
> > Fixes: c36ff266dc82 ("spi: Extend the core to ease integration of SPI memory controllers")

... not here.

The changelog should also contain a "Changes in v2" section.

> > ---
> >  drivers/spi/spi-mem.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > index 990770d..5ec2bc9 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -328,10 +328,24 @@ EXPORT_SYMBOL_GPL(spi_mem_exec_op);
> >  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> >  {
> >  	struct spi_controller *ctlr = mem->spi->controller;
> > +	unsigned long opcode_addr_dummy_sum = sizeof(op->cmd.opcode) +
> > +					      op->addr.nbytes +
> > +					      op->dummy.nbytes;  
> 

Yep, the var name is definitely too long.

> I'd split that (and shorten the variable name) to avoid line wrap. Maybe:
> 
> 	unsigned long len;
> 
> 	len = sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
> > 
> >  	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
> >  		return ctlr->mem_ops->adjust_op_size(mem, op);
> > 
> > +	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
> > +		if (spi_max_message_size(mem->spi) < opcode_addr_dummy_sum ||
> > +		    spi_max_transfer_size(mem->spi) < opcode_addr_dummy_sum)
> > +			return -EINVAL;  
> 
> Those comparisons are lexically backwards, you want 'value op constant'.
> So:
> 		if (len > spi_max_message_size(mem->spi) ||
> 		    len > spi_max_transfer_size(mem->spi))
> 			return -EINVAL.
> Although I'm surprised you need to do both comparisons.

Indeed, spi_max_transfer_size() is enough since it already does a min()
with spi_max_message_size().

> 
> > +
> > +		op->data.nbytes = min3((unsigned long)(op->data.nbytes),

Hm, you should have a cast of size_t, I guess that's what kbuild robots
reported.

> > +				       spi_max_transfer_size(mem->spi),
> > +				       spi_max_message_size(mem->spi) -
> > +				       opcode_addr_dummy_sum);  
> 
> That looks like a strange limit...

We need that to adjust the len of the 2nd transfer (called data in
spi-mem) if it's too long to fit in a SPI message or SPI transfer.

> 
> > +	}
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
> > --
> > 2.7.4  
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

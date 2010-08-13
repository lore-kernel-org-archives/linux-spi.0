From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2 v3] OMAP-McSPI: Update platform McSPI files
Date: Fri, 13 Aug 2010 16:27:15 -0600
Message-ID: <AANLkTimxZmg6ze635eFVB7vAcOsjSjFTPeecyx+DWG1m@mail.gmail.com>
References: <65423.192.168.10.88.1281707926.squirrel@dbdmail.itg.ti.com> <AANLkTikGagiRWqnsGazt20U8dXjx-gkeY6rd6610mcT=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	dbrownell@users.sourceforge.net, Hemanth V <hemanthv@ti.com>
To: "Govindraj.R" <govindraj.raja@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <AANLkTikGagiRWqnsGazt20U8dXjx-gkeY6rd6610mcT=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Aug 13, 2010 at 4:25 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, Aug 13, 2010 at 7:58 AM, Govindraj.R <govindraj.raja@ti.com> wrote:
>> + *
>> + * @fifo_depth when set to non zero values enables FIFO. fifo_depth
>> + * should be set as a multiple of buffer size used for read/write.
>> + */

Oh, and on this, which buffer size is being referred to?  The message
size, or something allocated internal to the bus driver?  The spi bus
driver will not have any foreknowledge of what buffer size is going to
be passed to it in spi messages.

g.

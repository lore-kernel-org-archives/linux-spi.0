From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] spi: add support for SPI over SuperH SCI pins
Date: Mon, 21 Jan 2008 20:38:48 -0800
Message-ID: <200801212038.48423.david-b@pacbell.net>
References: <20080121104913.11908.50319.sendpatchset@clockwork.opensource.se> <200801211429.29906.david-b@pacbell.net> <aec7e5c30801211956p285de9a6gfb8debafbb876c37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, lethal@linux-sh.org,
	linux-sh@vger.kernel.org
To: "Magnus Damm" <magnus.damm@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <aec7e5c30801211956p285de9a6gfb8debafbb876c37@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Monday 21 January 2008, Magnus Damm wrote:
> On Jan 22, 2008 7:29 AM, David Brownell <david-b@pacbell.net> wrote:
> >
> > You should consider adding yourself to MAINTAINERS for
> > this driver...
> 
> Yes. If it's ok with you then i'll send a separate patch for that. I
> should probably add more than one entry there.

Fine by me.  


> > > +     /* register the chips to go with the board */
> > > +
> > > +     for (i = 0; i < sp->info->board_size; i++) {
> > > +             dev_info(&dev->dev, "registering %p: %s\n",
> > > +                      &sp->info->board_info[i],
> > > +                      sp->info->board_info[i].modalias);
> > > +
> > > +             sp->info->board_info[i].controller_data = sp;
> > > +             spi_new_device(master, sp->info->board_info + i);
> >
> > NO -- this doesn't belong here at all.  Such registration is handled
> > by the SPI core code, according to what the board init code told it.
> 
> Hehe. My gut reaction was the same when i read the s3c24xx drivers,

Gaak.  How did those get in with such crap?

Aaaah, I see ... I never signed off on their original merge.  Hmm.



> but then I decided to follow their style. I'll remove that part then
> and instead register the spi devices from the board code using
> spi_register_board_info().
> 
> I'll fix up the code and repost in a bit. Thanks for your review!

Sure.

- Dave

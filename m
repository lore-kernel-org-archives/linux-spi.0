From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 0/6] ReST conversion patches not applied yet
Date: Wed, 31 Jul 2019 17:26:13 -0300
Message-ID: <20190731172613.32d65ad8@coco.lan>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
 <20190731141734.1fa9ce64@lwn.net>
 <20190731202007.GI4369@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Kleikamp <shaggy@kernel.org>,
 alsa-devel@alsa-project.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Evgeniy Polyakov <zbr@ioremap.net>,
 linux-cifs@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Corbet <corbet@lwn.net>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
 Evgeniy Dushistov <dushistov@mail.ru>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, samba-technical@lists.samba.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190731202007.GI4369@sirena.org.uk>
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

Em Wed, 31 Jul 2019 21:20:07 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Wed, Jul 31, 2019 at 02:17:34PM -0600, Jonathan Corbet wrote:
> > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:  
> 
> > > As promised, this is the rebased version of the patches that were not applied
> > > from the /26 patch series because you had merge conflicts.
> > > 
> > > They're all based on your docs-next branch, so should apply fine.
> > > 
> > > The first one fixes all but one error with a broken reference.
> > > 
> > > The only broken reference right now is due to a DT patch with was not
> > > accepted (no idea why), but whose driver is upstream.  
> 
> > All but 5/6 applied, thanks.  
> 
> Oh, I still hadn't reviewed this version of the SPI stuff :(

It is basically the one sent on that /26 patch series, just rebased
on the top of docs-next.

> There were outstanding questions about where it was going to get moved
> to but if I read the diff correctly it looks like it didn't actually get
> moved in the end?

Yeah, it doesn't have the move. My understanding from our discussions
is that we didn't reach a conclusion.

In any case, I can send a separate patch with the move part once
we reach an agreement about what's the best way to proceed (or you
can do it directly, if you prefer so).

Thanks,
Mauro

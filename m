From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Re: [PATCH 7/8] tools/Makefile: minor whitespace cleanup
Date: Tue, 17 Nov 2015 11:41:53 -0800
Message-ID: <1991766.ZT1k1WV0Gv@jclayton-pc>
References: <cover.1447773299.git.stillcompiling@gmail.com> <155366ac799345f42c8c342609ffa11b2df529b0.1447773299.git.stillcompiling@gmail.com> <20151117180924.GZ31303@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Adrian Remonda <adrianremonda@gmail.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151117180924.GZ31303@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tuesday, November 17, 2015 06:09:24 PM Mark Brown wrote:
> On Tue, Nov 17, 2015 at 07:24:27AM -0800, Joshua Clayton wrote:
> > Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> > ---
> >  tools/Makefile | 37 ++++++++++++++++++++++++++++++-------
> >  1 file changed, 30 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/Makefile b/tools/Makefile
> > index 9a617ad..428fb4d 100644
> > --- a/tools/Makefile
> > +++ b/tools/Makefile
> > @@ -80,10 +80,21 @@ turbostat_install x86_energy_perf_policy_install:
> >  tmon_install:
> >  	$(call descend,thermal/$(@:_install=),install)
> >  
> > -install: acpi_install cgroup_install cpupower_install hv_install firewire_install lguest_install \
> > -		perf_install selftests_install turbostat_install usb_install \
> > -		virtio_install vm_install net_install x86_energy_perf_policy_install \
> > -	tmon
> > +install: acpi_install \
> > +		cgroup_install \
> > +		cpupower_install \
> > +		hv_install \
> > +		firewire_install \
> > +		lguest_install \
> > +		perf_install \
> > +		selftests_install \
> > +		tmon \
> > +		turbostat_install \
> > +		usb_install \
> > +		virtio_install \
> > +		vm_install \
> > +		net_install \
> > +		x86_energy_perf_policy_install
> 
> This isn't a whitespace cleanup, this is a substantial reindentation of
> the file :(  Please ensure your changelogs are accurate and in general
> try to avoid mixing this sort of invasive stylistic change in with other
> patch serieses, it reduces the potential for conflicts.
Um.
Inability to resist Makefile cleanup is a weakness of mine. 
It is a tangent from the rest of the series so I'll drop it.

-- 
~Joshua Clayton

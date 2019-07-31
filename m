From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/6] ReST conversion patches not applied yet
Date: Wed, 31 Jul 2019 14:17:34 -0600
Message-ID: <20190731141734.1fa9ce64@lwn.net>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        samba-technical@lists.samba.org, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve French <sfrench@samba.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-cifs@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>,
        Mark Rutland <mark.rutland@arm.c
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1564603513.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 31 Jul 2019 17:08:47 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> As promised, this is the rebased version of the patches that were not applied
> from the /26 patch series because you had merge conflicts.
> 
> They're all based on your docs-next branch, so should apply fine.
> 
> The first one fixes all but one error with a broken reference.
> 
> The only broken reference right now is due to a DT patch with was not
> accepted (no idea why), but whose driver is upstream.

All but 5/6 applied, thanks.

jon

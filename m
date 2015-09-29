From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
 of WM510205 codec via ACPI (resend)
Date: Tue, 29 Sep 2015 08:57:15 +0100
Message-ID: <20150929075715.GG5432@ck-lbox>
References: <20150827145614.GC5313@sirena.org.uk>
 <CAKor6Tf8kB0WPXLTBFmCzUJkMVEDu-xTEyw0-_NZvBdFSyQSFA@mail.gmail.com>
 <CAKor6TfW4reRz3m-xkCr_ZUfHQkfqT3q+S7JCpO-9F+k1QW38g@mail.gmail.com>
 <CAKor6Tf7_Hiyc1v_TGvdVAU+G84Gp+KgKeSGi8EQJRoq9rhMuw@mail.gmail.com>
 <20150902081334.GB15505@ck-lbox>
 <CAKor6TdaRqi0+a0ZHkdJngE2LPKHk0PUFrdQQ2-x59cxUa8cXA@mail.gmail.com>
 <20150904143434.GA1514@edi-sw-dsktp001.ad.cirrus.com>
 <CAKor6TfhaHfqkmz-dogJ6dEUe06QFv-ee7uPOLiEGSTh3ibkhQ@mail.gmail.com>
 <20150928090852.GF5432@ck-lbox>
 <CAKor6Tc7pb_BnkZwhXDQ1+yMvC+YwXS3LO=5snZO65E8vsUgVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, jarkko.nikula@linux.intel.com,
 dan.carpenter@oracle.com, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Daniel Mack <daniel@zonque.org>
To: Christian Hartmann <cornogle@googlemail.com>
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CAKor6Tc7pb_BnkZwhXDQ1+yMvC+YwXS3LO=5snZO65E8vsUgVw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

On Tue, Sep 29, 2015 at 09:48:45AM +0200, Christian Hartmann wrote:
> Hi,
> 
> 
> > Ok no major hints from them, they do have a 10 inch version of
> > the same tablet lying around though so I will get them to post
> > that up and have a look see if I can figure anything out.
> >
> nice to hear, I am stuck at reading the chip registers ID value
> correctly at the moment.
> 
> > If you had anywhere I can pull in what you have done already that
> > would be handy.
> I have no such public or secure repo setup yet, time to do that.
> in that case with the wm510205 branched from torvalds/master, what do
> you prefer or
> is it okay, if I make an repo on github for it ??

Yeah branched of Linus's tree is probably best and shoving it on
github works for me.

Thanks,
Charles

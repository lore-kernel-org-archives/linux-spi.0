From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
 of WM510205 codec via ACPI (resend)
Date: Fri, 4 Sep 2015 15:34:34 +0100
Message-ID: <20150904143434.GA1514@edi-sw-dsktp001.ad.cirrus.com>
References: <CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
 <20150826100155.GA1513@lahna.fi.intel.com>
 <CAKor6TeH32hd0QUCPowzrjp54iJjGKiJ8jVT994y2O29dfk=QA@mail.gmail.com>
 <20150827115914.GF28428@lahna.fi.intel.com>
 <20150827145614.GC5313@sirena.org.uk>
 <CAKor6Tf8kB0WPXLTBFmCzUJkMVEDu-xTEyw0-_NZvBdFSyQSFA@mail.gmail.com>
 <CAKor6TfW4reRz3m-xkCr_ZUfHQkfqT3q+S7JCpO-9F+k1QW38g@mail.gmail.com>
 <CAKor6Tf7_Hiyc1v_TGvdVAU+G84Gp+KgKeSGi8EQJRoq9rhMuw@mail.gmail.com>
 <20150902081334.GB15505@ck-lbox>
 <CAKor6TdaRqi0+a0ZHkdJngE2LPKHk0PUFrdQQ2-x59cxUa8cXA@mail.gmail.com>
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
In-Reply-To: <CAKor6TdaRqi0+a0ZHkdJngE2LPKHk0PUFrdQQ2-x59cxUa8cXA@mail.gmail.com>
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

On Fri, Sep 04, 2015 at 03:32:03PM +0200, Christian Hartmann wrote:
> Hi,
> 
> 
> 2015-09-02 10:13 GMT+02:00 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>:
> > On Tue, Sep 01, 2015 at 11:45:31AM +0200, Christian Hartmann wrote:
> >> hi
> >>
> >> 2015-08-28 11:50 GMT+02:00 Christian Hartmann <cornogle@googlemail.com>:
> >> >
> > The chip select being wrong could well be the issue, perhaps the
> > Windows driver supports multiple chipselects where as the Linux
> > one doesn't? Do you have access to any datasheets for the SPI on
> > the AP? Alternatively you could try hacking it to use chip select
> > 0 and see if that makes the system work, seems like a long shot
> > but perhaps worth a quick go.
> >
> > Thanks,
> > Charles
> 
> ok, that was a one-shot, in effect nothing changed .
> I did set the num_chipsselect = 1 (as in vanilla kernels, so its more
> a revert) and
> changed the cs value from 1 to 0 (as a testpatch).
> as soon as the SPI device WM510205:00 is allocated,
> it tries to add the acpi_resource and in the case of the wrong SPI
> chip_select with the value 1 from the DSDT ACPI table entry, but here
> I set it again to 0.
> 
> expected : chip id register can be read, but
> nothing changed. the logs are the same in the end.
> I saw also that acpi_add_resource tries to add an irq (init with -1), but fails

Not entirely unexpected I guess, but certainly my gut feel here
is that this is a problem with the chip selects. I guess really
trying to find any available documentation on the AP/SPI and
tearing apart the SPI driver are the next steps from here. But
afraid I don't really have any great ideas for diving much
deeper. I will try to chase the Windows guys here again and see
if I can gain any clues from them but I don't really know at what
level these things are abstracted in Windows and thus if they can
really help us much.

Thanks,
Charles

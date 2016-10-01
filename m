From: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>
Subject: Re: [PATCH 0/2] Moving runnable code from Documentation (last 2
 patches)
Date: Sat, 1 Oct 2016 01:10:44 -0600
Message-ID: <20161001011044.70aefa33@lwn.net>
References: <cover.1474912582.git.shuahkh@osg.samsung.com>
        <0f5557aa-23ad-c37c-6d97-13789c0b5726@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Cc: mmarek-IBi9RG/b67k@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, jpoimboe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org, nikolay-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org,
        dvyukov-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org,
        arnd-r2nGTMty4D4@public.gmane.org, hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, nab-IzHhD5pYlfBP7FQvKIMDCQ@public.gmane.org,
        mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
        ecree-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org,
        linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kbuild-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shuah Khan <shuahkh-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0f5557aa-23ad-c37c-6d97-13789c0b5726-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 30 Sep 2016 07:57:51 -0600
Shuah Khan <shuahkh-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org> wrote:

> > This patch series contains the last 2 patches to complete moving runnable
> > code from Documentation to selftests, samples, and tools.
> > 
> > The first patch moves blackfin gptimers-example to samples and removes
> > CONFIG_BUILD_DOCSRC.
> > 
> > The second one updates 00-INDEX files under Documentation to reflect the
> > move of runnable code from Documentation.
> > 
> > Shuah Khan (2):
> >   samples: move blackfin gptimers-example from Documentation
> >   Doc: update 00-INDEX files to reflect the runnable code move
> >   
> 
> Hi Jon and Michal,
> 
> Do these patches look good to you? I can get these into 4.9-rc1
> with your Ack.

Seems good to me.

Acked-by: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

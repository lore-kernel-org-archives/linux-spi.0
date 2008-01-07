From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/7] convert semaphore to mutex in struct class
Date: Mon, 07 Jan 2008 17:36:32 +0100
Message-ID: <47825510.7050306@s5r6.in-berlin.de>
References: <20080103055019.GA4885@darkstar.te-china.tietoenator.com> <20080107020944.GA3637@darkstar.te-china.tietoenator.com> <20080107084528.GA8365@suse.de> <200801070101.15168.david-b@pacbell.net> <478227D5.8050402@s5r6.in-berlin.de> <20080107140014.GA2961@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b@pacbell.net>, Greg KH <gregkh@suse.de>,
	Dave Young <hidave.darkstar@gmail.com>,
	stern@rowland.harvard.edu, peterz@infradead.org,
	davem@davemloft.net, krh@redhat.com,
	dbrownell@users.sourceforge.net,
	James.Bottomley@hansenpartnership.com, a.zummo@towertech.it,
	cbou@mail.ru, dwmw2@infradead.org,
	linux1394-devel@lists.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	linux-scsi@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
To: Jarek Poplawski <jarkao2@gmail.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20080107140014.GA2961@ff.dom.local>
Sender: linux-scsi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Jarek Poplawski wrote:
>> David Brownell wrote:
>> > On Monday 07 January 2008, Greg KH wrote:
>> >> Most of the non-driver core code should be converted to not use the
>> >> lock in the class at all.  They should use a local lock instead.
>> > 
>> > Or better yet, that yet-to-be-written class_for_each_instance()
>> > iterator ... :)
...
> I hope I'm wrong, but IMHO it should be safer not to mix such changes,
> so do the mutexes first or delay them until the end. Otherwise some
> false blaming seems almost inevitable.

I agree.  Sem2mutex conversion should not be mixed with API conversion,
even if one or both seem trivial.
-- 
Stefan Richter
-=====-==--- ---= --===
http://arcgraph.de/sr/

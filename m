Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4F38E118
	for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329961; cv=pass; b=kXRtGfAha7Oty+/+yCHQyUS/eYadtUlngihNAPYKAwWj9J5qMTVbRdUgAly2ABOA4g9FJezqI2UGrWEVav8CewR7nEe8LKny5QFUHEA0QHcWDQCbD0cWkDReZetXfR8RODaQ+GpxiDaRKLcEKE593ZtHXKm/MRpAGDKudf8EpUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329961; c=relaxed/simple;
	bh=4tNFTOMSBZ1/Qp5RW7o3J5ezE7GBWsXKNJ/prrgOmk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGXssz+S0EM/nbr52H6Rr4B5lpOitvjOFPBOeCfkmJi19vBZbfy9rPSjRlxt41IkI03o4nzzS4Pfx86bDA7HK1zU31WSDGcyGJji3j87RTmUAQL/GpfHDu/laEf1wLJkmkLnNUa2fiR+CzgNMWo5LJX3v0619qbdVzjxBV/WTe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=e3vaIiIY; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="e3vaIiIY"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64937edbc9eso1229191d50.2
        for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2026 08:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773329958; cv=none;
        d=google.com; s=arc-20240605;
        b=A1pxTrQ3HhQF/QCNIawfNFD8BfW3Q5YRn0bQuQaFMwLhJ41G8KW+B6/oSO/o+eJQ51
         k1H6BS6Ripy97c3VRBaLhodA5s8cTfIBzyHxnt4ZI6qP5e5F1cgL0g75yiGZ3LXyH0f+
         lfOB+c9UClUvAW0sTY2ilci7wzI96X6/xmv2YnhkUmj3p1r3PrFEJYZ1pgiKUWQuHwZs
         YM7FcM7OFtC1O7+fGhZ3voc9+awuQ4O62PSTPiRMACC584rJgeFMvodIuphCNr30DR1q
         rDrxgq22u/Q8Hkq77pEA5qDyX6oUWFQ3xJvedYEKLO6FPvEd2kcpiq/S8eF3ukXfCpVz
         4BBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
        fh=YB/e5OayxeN4jNr7QC0lVhl5NVeiXSWOTFsMYHCNKq8=;
        b=RzZqgdQ5rww5+ogAHdrvYxpgpK5Q/iCK4tlul1YJQl8t5kkJOkRsxtPqoigUT2t/Ud
         BTDxwBWLSBd7KPFq749Rs3p2vKfi2TEyz3EYkyhZ2Bn0+SKzrPcvPtKgrd4bK0HWGyD5
         NyBFwsb1fDjSJvNZAnVOAXgRali51YEimiij6A2p7kkaqnBJDH0MfKX4rwc0HtWrSbDa
         zI6sy49/MwA2LhBLt+wk2Ls5r7jIhTb+cyjsKNTcLpbqrbYHmbi5vQv5L/FkVLOrPPst
         5jLejra/SHl7XjqmbJXEpzhP2loSm/mMFOTUAC8MaC+TBqgu/Aat3cg1Jp0C4z0JIFvI
         DudA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773329958; x=1773934758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
        b=e3vaIiIYGWUOtCfN3v0i0XwlQU8iKw5tKJiDxrs5BpZgUFpI7tsKG3ZooWaPnqOdPC
         Z8SAY5DTLTvpjaOB6s9bQ3ZxX+LcGGgsdf6NZnIPHM+cPfYf7mdvQUxOUB0MAZatRAPX
         OPlQ6GS038tCrg8KJ4MGW9OOzjznHa++hyHmoFietr8QqWOe5FW8fUSSVZIetM87CB5M
         jIZEMQ7uYMS4Ig4PCqqRV43UmxiY9EVL0EW92WOQZ4YI2E2FPpEUlNbyASWYFFksXS3t
         9mACIIHPFuYoU4rBir3aqJDHbJg+APFP1wB7a8eG0Ml1cARiYuzc0pJgDxzADpeGYDNg
         MfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329958; x=1773934758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
        b=VeBbhl4pafr34fIEA97K4CojyazGEUjOFhN0VFgmICdkSsy3iuN6yBuzzBuLc0sQR7
         gN+uKSw+gX2GNYhzqd78I/VPXFpOJS2A2rS1eZZN7jmLlGPCR7cM30cqHGc5JQRWzzlS
         4hAHheH1MnDLK9El9lm9ICf6tmfeM+eei1+6i432n/61tVmXTxt+VbKLVXXd3/W6b/a5
         7zdH8bf3L1XKnXtzRJlRBDfdSGsK8TxHVoQmsoa3YE9ZqwXd3G+p42iJGO+2SV66/TdE
         Gq0/0MLXvijvXgocSsIeEA+V6NE60Ik+EDfegA/TXwGIUwHDbUklXdQ6Ccs9hLIUtjWi
         ea8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3MzBE3TWC30KoZkU0O4dENYs1ECpW0XTl12pp/b3XC6I6xb4ViGY0IWQviDkA2k9n8j9uTb6vQqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVp8rSMfu/FRt9tjswe3yKJEf+UNrYtmZ9Lxr7wF79CKoE6yYv
	DEiM9EJMTrQOvzoa6El0rGsPcQlqKHVvoTfoOGyGP0cz46/Qsed4ldXjBlC0WP48geuXem5riWz
	VgGoflmflJGgur3URCvA9q2FvNyoeXsmfsQwtC7y9XA==
X-Gm-Gg: ATEYQzwtcu4KZ7DemvxsR99mE3PrH0inDa2gLHnInAYfbY5FzHOlzJZW+EO6EWGoPpT
	BuCzWSeBlskrzvwbiduL9ulJgt2h+8noMdOni4MEIRlZl88gjmtoYVsQyA9nk+9Al2hxqqOGA2h
	1xJE2NHj90+RC0/YPa10mAk+hR0mxWabnI1WQEMcsyJFqATebvwdDZyXyhAYssPdlmJSHQAGdwc
	RwToX4rCe4MxbDFevPWCOjbnwsoeC8KDAuKrwLd6vuZGXwnBqCmJSdNZz95dbzpZ8WuF/D0JKal
	FvcBs2d141dbfH+DdQ==
X-Received: by 2002:a53:bb8d:0:b0:64d:5742:5ab0 with SMTP id
 956f58d0204a3-64d6577eb37mr4463263d50.43.1773329958142; Thu, 12 Mar 2026
 08:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-2-vineeth@bitbyteword.org> <20260312111255.7925b4e2@gandalf.local.home>
In-Reply-To: <20260312111255.7925b4e2@gandalf.local.home>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Thu, 12 Mar 2026 11:39:06 -0400
X-Gm-Features: AaiRm53MQsKCFNMcydaZ5MLANW9ImopAkQThe-DUzJ0WQT8Ah4MCG48E4vTQfog
Message-ID: <CAO7JXPhg-Etspj9YahZrq8cmZ2K6AGWDrMnHO+oD96P_SmOLBw@mail.gmail.com>
Subject: Re: [PATCH 01/15] tracepoint: Add trace_invoke_##name() API
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	dev@openvswitch.org, Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
	dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
	Eddie James <eajames@linux.ibm.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 11:13=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 12 Mar 2026 11:04:56 -0400
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
>
> > Add trace_invoke_##name() as a companion to trace_##name().  When a
> > caller already guards a tracepoint with an explicit enabled check:
> >
> >   if (trace_foo_enabled() && cond)
> >       trace_foo(args);
> >
> > trace_foo() internally repeats the static_branch_unlikely() test, which
> > the compiler cannot fold since static branches are patched binary
> > instructions.  This results in two static-branch evaluations for every
> > guarded call site.
> >
> > trace_invoke_##name() calls __do_trace_##name() directly, skipping the
> > redundant static-branch re-check.  This avoids leaking the internal
> > __do_trace_##name() symbol into call sites while still eliminating the
> > double evaluation:
> >
> >   if (trace_foo_enabled() && cond)
> >       trace_invoke_foo(args);   /* calls __do_trace_foo() directly */
> >
> > Three locations are updated:
> > - __DECLARE_TRACE: invoke form omits static_branch_unlikely, retains
> >   the LOCKDEP RCU-watching assertion.
> > - __DECLARE_TRACE_SYSCALL: same, plus retains might_fault().
> > - !TRACEPOINTS_ENABLED stub: empty no-op so callers compile cleanly
> >   when tracepoints are compiled out.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > Assisted-by: Claude:claude-sonnet-4-6
>
> I'm guessing Claude helped with the other patches. Did it really help wit=
h this one?
>

Claude wrote and build tested the whole series based on my guidance
and prompt :-). I verified the series before sending it out, but
claude did the initial work.

Thanks,
Vineeth
